
#define _GNU_SOURCE

#include <gtk/gtk.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <regex.h>
#include "structs/types.h"

//-Globais-//

GtkWidget *window;
GtkWidget *grid;
GtkEntryBuffer *bufferS;
GtkTextBuffer *bufferConsole, *bufferInput;
GtkWidget *viewC;
GtkListStore *storeCode, *storeHeap, *storeOP, *storeCall;
GtkWidget *labelPC, *labelFP, *labelSP, *labelGP;
GtkWidget *buttonR, *button1, *buttonN;

regex_t regexCode, regexCall, regexHeap, regexOp;

#define PC 0
#define FP 1
#define SP 2
#define GP 3

void insCode(char*);
void insCall(char*);
void insOP(char*);
void insHeap(char*);

//-----------------------------------------------------------------------------//

void quickInput (GtkWindow *parent, gchar *message, GtkEntryBuffer *buffer) {

 GtkWidget *label, *content_area;
 GtkDialogFlags flags;

 GtkWidget *dialog = gtk_dialog_new ();
 GtkWidget *entry;
 entry = gtk_entry_new_with_buffer (buffer);

 flags = GTK_DIALOG_DESTROY_WITH_PARENT;
 dialog = gtk_dialog_new_with_buttons ("Input Mensagem", parent, flags, ("_OK"), GTK_RESPONSE_NONE, NULL);
 content_area = gtk_dialog_get_content_area (GTK_DIALOG (dialog));
 label = gtk_label_new (message);
 gtk_window_set_deletable (GTK_WINDOW (dialog), FALSE);

 gtk_entry_set_activates_default (GTK_ENTRY (entry), TRUE);

 gtk_window_set_modal(GTK_WINDOW (dialog), TRUE);
 g_signal_connect_swapped (dialog, "response", G_CALLBACK (gtk_widget_destroy), dialog);
 gtk_container_add (GTK_CONTAINER (content_area), label);
 gtk_container_add (GTK_CONTAINER (content_area), entry);

 gtk_widget_show_all (dialog);
 gtk_dialog_run (GTK_DIALOG (dialog));
}

//-----------------------------------------------------------------------------//

void getInput(char **input) {

  GtkTextIter inicio, fim;
  char *aux;

  gtk_text_buffer_get_iter_at_line (bufferInput, &inicio, 0);
  gtk_text_buffer_get_iter_at_line (bufferInput, &fim, 1);

  if ( gtk_text_iter_get_line(&fim) == 0 ) { // ZERO / MEIA
    if (gtk_text_iter_ends_line (&inicio)) { // ZERO
      GtkEntryBuffer *bufferLine = gtk_entry_buffer_new ("",0);
      quickInput(GTK_WINDOW (window), "Por favor insira input para continuar a execucao do programa", bufferLine);
      aux = (char*)gtk_entry_buffer_get_text (bufferLine);
      asprintf(input, "%s\n", aux);
      //const char *ts = gtk_entry_buffer_get_text (bufferLine);
      //*input = (char*)ts;
    } else { // MEIA
      while (!gtk_text_iter_ends_sentence (&fim)) { gtk_text_iter_forward_chars (&fim, 1); }
      gtk_text_buffer_insert (bufferInput, &fim, "\n", 1);
      gtk_text_buffer_get_iter_at_line (bufferInput, &inicio, 0);
      *input = gtk_text_buffer_get_text (bufferInput, &inicio, &fim, FALSE);
      gtk_text_buffer_delete (bufferInput, &inicio, &fim);
    }
  } else { // UMA OU MAIS / VAZIA
    *input = gtk_text_buffer_get_text (bufferInput, &inicio, &fim, FALSE);
    if (gtk_text_iter_ends_line (&inicio)) { // VAZIA
      GtkEntryBuffer *bufferLine = gtk_entry_buffer_new ("",0);
      quickInput(GTK_WINDOW (window), "Por favor insira input para continuar a execucao do programa", bufferLine);
      aux = (char*)gtk_entry_buffer_get_text (bufferLine);
      asprintf(input, "%s\n", aux);
    } // UMA
    gtk_text_buffer_delete (bufferInput, &inicio, &fim);
  }
}

void actLabel (int lab, int value) {

  char l[10], b[5];
  sprintf(b, "%d", value);
  switch (lab) {
    case PC:
      strncpy(l, "PC:", 10); strcat(l,b);
      gtk_label_set_text (GTK_LABEL (labelPC), l); break;
    case FP:
      strncpy(l, "FP:", 10); strcat(l,b);
      gtk_label_set_text (GTK_LABEL (labelFP), l); break;
    case SP:
      strncpy(l, "SP:", 10); strcat(l,b);
      gtk_label_set_text (GTK_LABEL (labelSP), l); break;
    case GP:
      strncpy(l, "GP:", 10); strcat(l,b);
      gtk_label_set_text (GTK_LABEL (labelGP), l); break;
    default :
    ;
  }
}

    //-----------------------------------------//

void freeLine(char** line, int t) {
  for(int i=0; i<t; i++) free(line[i]);
}

//-----------------------------------------------------------------------------//

static void turnButtons (_Bool b) {
  gtk_widget_set_sensitive (buttonR, b);
  gtk_widget_set_sensitive (button1, b);
  gtk_widget_set_sensitive (buttonN, b);
}

static void limpaStacks() {
  gtk_list_store_clear (storeCode);
  gtk_list_store_clear (storeHeap);
  gtk_list_store_clear (storeOP);
  gtk_list_store_clear (storeCall);

  gtk_text_buffer_set_text (bufferConsole,"",0);
}

void cleanReload () {
  actLabel(PC,0);
  actLabel(FP,0);
  actLabel(SP,0);
  actLabel(GP,0);

  GtkTextIter inicio, fim;
  gtk_text_buffer_get_start_iter (bufferConsole, &inicio);
  gtk_text_buffer_get_end_iter (bufferConsole, &fim);
  gtk_text_buffer_delete (bufferConsole, &inicio, &fim);
}

//-----------------------------------------------------------------------------//

void parseLine(char* line) {
  char *input;

  GtkTextIter fim;
  gtk_text_buffer_get_end_iter (bufferConsole, &fim);
  //gtk_text_buffer_get_iter_at_line (bufferConsole, &fim, gtk_text_buffer_get_line_count(bufferConsole));
  //gtk_text_buffer_insert (bufferConsole, &fim, line, strlen(line));

  if      (!strncmp(line, "> CO", 4)) {insCode(line); turnButtons(TRUE);}
  else if (!strncmp(line, "> CA", 4)) insCall(line);
  else if (!strncmp(line, "> OP", 4)) insOP(line);
  else if (!strncmp(line, "> HE", 4)) insHeap(line);
  else if (!strncmp(line, "> IN", 4)) {
    getInput(&input);
    gtk_text_buffer_insert(bufferConsole, &fim, input, strlen(input));
    fprintf(stdout, "%s", input); fflush(stdout);
    free(input);
  }
  else if(!strncmp(line, "> OU", 4)) {
    line[12 + strlen(&line[12]) -3] = '\0';
    gtk_text_buffer_insert(bufferConsole, &fim, &line[12], strlen(&line[12]));
    //gtk_text_buffer_set_text (bufferConsole, &line[9], strlen(&line[9]));
  }
}

void loopTranformations(){
  char *buf;
  size_t cap=0;
  ssize_t len;
  char *line=(char*)malloc(1);
  line[0]='>';
  while(line[0] == '>'){
    //fgets(line, MAX_LINE, stdin);
    free(line); line=NULL; cap=0;
    len = getline(&line, &cap, stdin);
    if(line[len-2]=='\"'){
      asprintf(&buf, "%s", line);
      len = getdelim(&line, &cap, '\"', stdin);
      asprintf(&buf, "%s%s", buf, line);
      len = getline(&line, &cap, stdin);
      asprintf(&buf, "%s%s", buf, line);
     // g_message("%s", buf);
      free(line); line=(char*)malloc(1); line[0]='>';
      parseLine(buf);
    }
    else { parseLine(line); }
  }
  free(line);
  line=NULL;
}

//-----------------------------------------------------------------------------//

void GtkFileOpen (char **retFilename) {

  GtkWidget *dialog;
  GtkFileChooserAction action = GTK_FILE_CHOOSER_ACTION_OPEN;
  gint res;

  dialog = gtk_file_chooser_dialog_new ("Open File", GTK_WINDOW (window), action, ("Cancel"), GTK_RESPONSE_CANCEL, ("Open"), GTK_RESPONSE_ACCEPT, NULL);

  res = gtk_dialog_run (GTK_DIALOG (dialog));
  if (res == GTK_RESPONSE_ACCEPT) {
      GtkFileChooser *chooser = GTK_FILE_CHOOSER (dialog);
      *retFilename = gtk_file_chooser_get_filename (chooser);
  }
  gtk_widget_destroy (dialog);
}

    //-----------------------------------------//

static void exeInst (const char* nvezes) {
  if(nvezes[0] == '0') fprintf(stdout, "run \n");
  else                 fprintf(stdout, "next %s\n", nvezes);
  fflush(stdout);
  loopTranformations();
}

static void bExe (GtkWidget *widget, gpointer data) {
  exeInst("1");
}

static void bExeT (GtkWidget *widget, gpointer data) {
  const char* n = gtk_entry_buffer_get_text(bufferS);
  exeInst(n);
}

static void bLoadPFile (GtkWidget *widget, gpointer data) {

  //if(lastfile != NULL) { free(lastfile); }
  char* inputFile=NULL;
  GtkFileOpen(&inputFile);
  if (inputFile != NULL) {
    fprintf(stdout, "file %s\n", inputFile); fflush(stdout);
    limpaStacks();
    turnButtons(TRUE);
    loopTranformations();
  }
  //else { turnButtons(FALSE); }
}

static void bReloadFile (GtkWidget *widget, gpointer data) {

  limpaStacks();
  cleanReload();
  fprintf(stdout, "reload  \n"); fflush(stdout);
  turnButtons(TRUE);
  loopTranformations();
}

static void bLoadIFile (GtkWidget *widget, gpointer data) {
  char* inputFile=NULL;
  GtkFileOpen(&inputFile);
  cleanReload();

  if (inputFile != NULL) {
    GError *err = NULL;
    gchar *contents;

    g_file_get_contents (inputFile, &contents, NULL, &err);
    gtk_text_buffer_set_text (bufferInput, contents, strlen(contents));
  }
  //else { turnButtons(FALSE); }
}

//-----------------------------------------------------------------------------//

static void activateLables () {

  GtkWidget *label;

  label = gtk_label_new ("Code");
  gtk_grid_attach (GTK_GRID (grid), label, 0, 0, 1, 1);
  label = gtk_label_new ("Heap");
  gtk_grid_attach (GTK_GRID (grid), label, 2, 0, 1, 1);
  label = gtk_label_new ("OPStack");
  gtk_grid_attach (GTK_GRID (grid), label, 1, 0, 1, 1);
  label = gtk_label_new ("Call Stack");
  gtk_grid_attach (GTK_GRID (grid), label, 2, 10, 1, 1);

  //-------------------------------------------//

  labelPC = gtk_label_new ("PC:0");
  gtk_grid_attach (GTK_GRID (grid), labelPC, 3, 0, 1, 1);
  labelFP = gtk_label_new ("FP:0");
  gtk_grid_attach (GTK_GRID (grid), labelFP, 4, 0, 1, 1);
  labelSP = gtk_label_new ("SP:0");
  gtk_grid_attach (GTK_GRID (grid), labelSP, 5, 0, 1, 1);
  labelGP = gtk_label_new ("GP:0");
  gtk_grid_attach (GTK_GRID (grid), labelGP, 6, 0, 1, 1);
}

//-----------------------------------------------------------------------------//

static void activateInputs () {

  GtkWidget *entry;

  bufferS = gtk_entry_buffer_new ("1", 1);
  entry = gtk_entry_new_with_buffer (bufferS);
  gtk_entry_set_max_length (GTK_ENTRY (entry), 5);
  gtk_grid_attach (GTK_GRID (grid), entry, 5, 2, 2, 1);

    //-----------------------------------------//

  GtkWidget *button;

  button1 = gtk_button_new_with_label ("Execute 1");
  g_signal_connect (button1, "clicked", G_CALLBACK (bExe), NULL);
  gtk_widget_set_sensitive (button1, FALSE);
  gtk_grid_attach (GTK_GRID (grid), button1, 3, 1, 4, 1);
  buttonN = gtk_button_new_with_label ("Execute N:");
  g_signal_connect (buttonN, "clicked", G_CALLBACK (bExeT), NULL);
  gtk_widget_set_sensitive (buttonN, FALSE);
  gtk_grid_attach (GTK_GRID (grid), buttonN, 3, 2, 2, 1);
  button = gtk_button_new_with_label ("Load Program File");
  g_signal_connect (button, "clicked", G_CALLBACK (bLoadPFile), NULL);
  gtk_grid_attach (GTK_GRID (grid), button, 3, 3, 2, 1);
  buttonR = gtk_button_new_with_label ("Reload Program File");
  g_signal_connect (buttonR, "clicked", G_CALLBACK (bReloadFile), NULL);
  gtk_widget_set_sensitive (buttonR, FALSE);
  gtk_grid_attach (GTK_GRID (grid), buttonR, 5, 3, 2, 1);
  button = gtk_button_new_with_label ("Load Input File");
  g_signal_connect (button, "clicked", G_CALLBACK (bLoadIFile), NULL);
  gtk_grid_attach (GTK_GRID (grid), button, 3, 4, 4, 1);

    //-----------------------------------------//

  GtkWidget *scrolled_window;
  GtkWidget *view;

  scrolled_window = gtk_scrolled_window_new (NULL, NULL);
  gtk_widget_set_hexpand (scrolled_window, FALSE);
  gtk_widget_set_vexpand (scrolled_window, FALSE);

  view = gtk_text_view_new();
  bufferInput = gtk_text_view_get_buffer(GTK_TEXT_VIEW(view));

  gtk_text_view_set_editable (GTK_TEXT_VIEW (view), TRUE);
  gtk_text_view_set_cursor_visible (GTK_TEXT_VIEW (view), TRUE);
  gtk_container_add (GTK_CONTAINER (scrolled_window), view);
  gtk_grid_attach (GTK_GRID (grid), scrolled_window, 3, 13, 4, 7);

    //-----------------------------------------//

  scrolled_window = gtk_scrolled_window_new (NULL, NULL);
  gtk_widget_set_hexpand (scrolled_window, FALSE);
  gtk_widget_set_vexpand (scrolled_window, FALSE);

  view = gtk_text_view_new();
  bufferConsole = gtk_text_view_get_buffer(GTK_TEXT_VIEW(view));

  gtk_text_view_set_editable (GTK_TEXT_VIEW (view), FALSE);
  gtk_text_view_set_cursor_visible (GTK_TEXT_VIEW (view), FALSE);
  gtk_container_add (GTK_CONTAINER (scrolled_window), view);
  gtk_grid_attach (GTK_GRID (grid), scrolled_window, 3, 5, 4, 8);

}

//-----------------------------------------------------------------------------//

void remLinha(int i, GtkListStore* a) {
  GtkTreeIter iter;
  GtkTreePath *path;
  path = gtk_tree_path_new_from_indices (i, -1);
  gtk_tree_model_get_iter(GTK_TREE_MODEL(a), &iter, path);
  gtk_list_store_remove (GTK_LIST_STORE(a), &iter);
}

void getGroups(char* line, regex_t *regex , char** arr, regmatch_t* gr, int NUM_COLS){
	regexec(regex, line, NUM_COLS, gr, 0);
    for (int i = 0; i < NUM_COLS; i++) {
      int len = gr[i].rm_eo - gr[i].rm_so;
      arr[i] = (char*)malloc(len+1);
      strncpy(arr[i], &line[gr[i].rm_so], len);
      arr[i][len] = '\0';
      //g_message("Group %u: [%lld-%lld]: %s\n", i, gr[i].rm_so, gr[i].rm_eo, arr[i]);
    }
}
  //-----------------------------------------//


void insCode(char *line) {

  GtkTreeIter iter;
  GtkTreePath *path=NULL;
  enum stack {Index, Instruction, ValueA, TypeA, ValueB, TypeB, NUM_COLS };
  int nGroups = NUM_COLS+2+1; //signal, pc, tudo
  char* arr[nGroups];
	regmatch_t gr[nGroups];

  getGroups(line, &regexCode, arr, gr, nGroups);
  if(arr[1][0] == '+'){
    gtk_list_store_append(storeCode, &iter);
    gtk_list_store_set (storeCode, &iter, Index, arr[2], Instruction, arr[3],
       ValueA, arr[5], TypeA, arr[4], ValueB, arr[7], TypeB, arr[6], -1);
        path = gtk_tree_path_new_from_string ("0");
    }
  else if(arr[1][0] == '_') path = gtk_tree_path_new_from_string (arr[2]);

  gtk_tree_model_get_iter(GTK_TREE_MODEL(storeCode), &iter, path);
  gtk_tree_view_set_cursor (GTK_TREE_VIEW (viewC), path, NULL, FALSE);
  actLabel(PC, atoi(arr[8]));
  freeLine(arr, nGroups);
}

void insOP(char *line) {

    GtkTreeIter iter;
    GtkTreePath *path;
    enum stack {Index, Value, Type, NUM_COLS };
    int nGroups = NUM_COLS+4+1;
    char* arr[nGroups];
    regmatch_t gr[nGroups];

    getGroups(line, &regexOp, arr, gr, nGroups);
    if(arr[1][0] == '+'){
        gtk_list_store_append(storeOP, &iter);
        gtk_list_store_set(storeOP, &iter, Index, arr[2],
                                           Value, arr[4],
                                           Type,  arr[3],
                                           -1);
    }
    else if(arr[1][0] == '-') remLinha(atoi(arr[5]),storeOP);
    else if(arr[1][0] == '~'){
        path = gtk_tree_path_new_from_string(arr[2]);
        gtk_tree_model_get_iter(GTK_TREE_MODEL(storeOP), &iter, path);
        gtk_tree_path_free(path);
        gtk_list_store_set(storeOP, &iter, Index, arr[2],
                                           Value, arr[4],
                                           Type,  arr[3],
                                           -1);

    }
    actLabel(SP, atoi(arr[5]));
    actLabel(FP, atoi(arr[6]));
    actLabel(GP, atoi(arr[7]));
    freeLine(arr, nGroups);
}

void insHeap(char *line) {

    GtkTreeIter iter;
    GtkTreePath *path;
    enum stack {Index, Value, NUM_COLS };
    int nGroups = NUM_COLS+1+1;
    char* arr[nGroups];
    regmatch_t gr[nGroups];

    getGroups(line, &regexHeap, arr, gr, nGroups);
    if(arr[1][0] == '+'){
        gtk_list_store_append(storeHeap, &iter);
        gtk_list_store_set (storeHeap, &iter, Index, arr[2],
                                              Value, arr[3],
                                              -1);
    }
    else if(arr[1][0] == '-') remLinha(atoi(arr[2]),storeHeap);
    else if(arr[1][0] == '~'){
        //g_message("%s", arr[2]);
        path = gtk_tree_path_new_from_string(arr[2]);
        gtk_tree_model_get_iter(GTK_TREE_MODEL(storeHeap), &iter, path);
        gtk_tree_path_free(path);
        gtk_list_store_set(storeHeap, &iter, Index, arr[2],
                                           Value, arr[3],
                                           -1);
    }
    freeLine(arr, nGroups);
}

void insCall(char *line) {

    GtkTreeIter iter;
    enum stack {Index, PcValue, FpValue , NUM_COLS };
    int nGroups = NUM_COLS+1+1;
    char* arr[nGroups];
    regmatch_t gr[nGroups];

    getGroups(line, &regexCall, arr, gr, nGroups);
    if(arr[1][0] == '+'){
        gtk_list_store_append(storeCall, &iter);
        gtk_list_store_set (storeCall, &iter, Index,    arr[2],
                                              PcValue,  arr[3],
                                              FpValue,  arr[4],
                                              -1);
    }
    else if(arr[1][0] == '-')remLinha(atoi(arr[2]), storeCall);
    freeLine(arr, nGroups);
}

//-----------------------------------------------------------------------------//

static void criarJanela (GtkWidget *view, int x, int y, int xx, int yy) {

  GtkWidget *scrolled_window;
  scrolled_window = gtk_scrolled_window_new (NULL, NULL);
  gtk_widget_set_hexpand (scrolled_window, TRUE);
  gtk_widget_set_vexpand (scrolled_window, TRUE);
  gtk_container_add (GTK_CONTAINER (scrolled_window), view);
  gtk_grid_attach (GTK_GRID (grid), scrolled_window, x, y, xx, yy);
}

//-----------------------------------------------------------------------------//

static void activateSCode (int x, int y, int xx, int yy) {
  GtkCellRenderer *renderer;
  GtkTreeModel    *model;

  viewC = gtk_tree_view_new ();
  renderer = gtk_cell_renderer_text_new ();\

  enum stack {Index, Instruction, ValueA, TypeA, ValueB, TypeB, NUM_COLS };
  static const char *nomes[] = {"#--", "Instruction", "ValueA", "TypeA", "ValueB", "TypeB"};
  storeCode = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);

  for (int coluna = Index; coluna < NUM_COLS; coluna++) {
    gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (viewC), -1, nomes[coluna], renderer, "text", coluna, NULL);
  }

  model = GTK_TREE_MODEL (storeCode);
  gtk_tree_view_set_model (GTK_TREE_VIEW (viewC), model);

  criarJanela(viewC, x, y, xx, yy);
}

  //-----------------------------------------//

static void activateSHeap (int x, int y, int xx, int yy) {

  GtkWidget       *view;
  GtkCellRenderer *renderer;
  GtkTreeModel    *model;

  view = gtk_tree_view_new ();
  renderer = gtk_cell_renderer_text_new ();\

  enum stack {Index, Value, NUM_COLS };
  static const char *nomes[] = {"#--", "Value", "Type"};
  storeHeap = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING);

  for (int coluna = Index; coluna < NUM_COLS; coluna++) {
    gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view), -1, nomes[coluna], renderer, "text", coluna, NULL);
  }

  model = GTK_TREE_MODEL (storeHeap);
  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  criarJanela(view, x, y, xx, yy);
}

  //-----------------------------------------//

static void activateSOP (int x, int y, int xx, int yy) {

  GtkWidget       *view;
  GtkCellRenderer *renderer;
  GtkTreeModel    *model;

  view = gtk_tree_view_new ();
  renderer = gtk_cell_renderer_text_new ();\

  enum stack {Index, PcValue, FpValue, NUM_COLS };
  static const char *nomes[] = {"#--", "Value", "Type"};
  storeOP = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);

  for (int coluna = Index; coluna < NUM_COLS; coluna++) {
    gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view), -1, nomes[coluna], renderer, "text", coluna, NULL);
  }

  model = GTK_TREE_MODEL (storeOP);
  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  criarJanela(view, x, y, xx, yy);
}

    //-----------------------------------------//

static void activateSCall (int x, int y, int xx, int yy) {

  GtkWidget       *view;
  GtkCellRenderer *renderer;
  GtkTreeModel    *model;

  view = gtk_tree_view_new ();
  renderer = gtk_cell_renderer_text_new ();

  enum stack {Index, PcValue, FpValue, NUM_COLS };
  static const char *nomes[] = {"#--", "PcValue", "FpValue"};
  storeCall= gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);

  for (int coluna = Index; coluna < NUM_COLS; coluna++) {
    gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view), -1, nomes[coluna], renderer, "text", coluna, NULL);
  }

  model = GTK_TREE_MODEL (storeCall);
  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  criarJanela(view, x, y, xx, yy);
}

//-----------------------------------------------------------------------------//

void activateStacks () {
  activateSCode (0, 1, 1, 19);
  activateSHeap (2, 1, 1, 9);
  activateSCall (2, 11, 1, 9);
  activateSOP   (1, 1, 1, 19);

  //GtkTreeSelection x;
}

//-----------------------------------------------------------------------------//

static void activate () {
  grid = gtk_grid_new ();
  gtk_container_add (GTK_CONTAINER (window), grid);
  gtk_grid_set_row_spacing (GTK_GRID (grid),10);
  gtk_grid_set_column_spacing (GTK_GRID (grid),10);
  //gtk_grid_set_column_homogeneous (GTK_GRID (grid),TRUE);

  activateInputs ();
  activateStacks ();
  activateLables ();

  gtk_widget_show_all (window);
}

//-----------------------------------------------------------------------------//

void initRegex(){
	char *regexStringCode = "> CODE ([-+_]) ([0-9]+) ([A-Z]+|_) ([A-Z_]+|_) (\"[^\"]*\"|-?[0-9.]+|_) ([A-Z_]+|_) (\"[^\"]*\"|-?[0-9.]+|_) ([0-9]+)",
       *regexStringOp   = "> OPSTACK ([-+~_]) (-?[0-9]+) ([A-Z_]+|_) (-?[0-9.]+|_) ([0-9]+) ([0-9]+) ([0-9]+)",
       *regexStringCall = "> CALLSTACK ([-+_]) ([0-9]+) ([0-9]+) ([0-9]+)",
       *regexStringHeap = "> HEAP ([-+~_]) ([0-9]+) \"\n(.?|[ \n\t\\])\n\"|\"\n";

    if (regcomp(&regexCode, regexStringCode, REG_EXTENDED)) { g_message("Could not compile regular expression: Code.\n"); exit(-1); }
    if (regcomp(&regexOp  , regexStringOp  , REG_EXTENDED)) { g_message("Could not compile regular expression: Op.\n"  ); exit(-1); }
    if (regcomp(&regexHeap, regexStringHeap, REG_EXTENDED)) { g_message("Could not compile regular expression: Heap.\n"); exit(-1); }
    if (regcomp(&regexCall, regexStringCall, REG_EXTENDED)) { g_message("Could not compile regular expression: Call.\n"); exit(-1); }
}

int main (int argc, char **argv) {
  gtk_init (&argc, &argv);

  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  gtk_window_set_default_size(GTK_WINDOW(window), 800, 400);
  gtk_window_set_title (GTK_WINDOW (window), "VMS-Projeto");
  gtk_container_set_border_width (GTK_CONTAINER (window), 10);

  g_signal_connect (window, "destroy", G_CALLBACK(gtk_main_quit), NULL);

  initRegex();
  activate();

  gtk_widget_show (window);
  loopTranformations();
  gtk_main ();
  return 0;
}

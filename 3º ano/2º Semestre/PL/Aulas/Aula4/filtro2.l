%option noyywrap
%x MD ABC P T

%%

<*>title:         BEGIN T;
<*>\<abc\>        BEGIN ABC;
<*>\<\/abc\>      BEGIN P;
<T>\n             BEGIN MD;
<T>\*             {}
<MD>\n\n          BEGIN p;
<MD>.|\n          {}
<ABC>.|\n         {}
<P>_              {}
<P>\ \ .*         {}



%%
int main(){
  yyflex();
  return 0;
}

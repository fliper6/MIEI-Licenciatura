

#include<stdio.h>
#include<stdlib.h>

#define _USE_MATH_DEFINES
#include <math.h>
#include <vector>

#include <IL/il.h>

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glew.h>
#include <GL/glut.h>
#endif
using namespace std;


struct Ponto {
	float x, y, z;
};

vector<Ponto> pontos;

vector<float> alturas;

GLuint buffers[1];

unsigned int t, tw, th;
unsigned char* imageData;
int time = 0;
int arvore = 0;

float camX = 0.01, camY = 0, camZ = 0.01;
float lookx = 10.0, looky = 3.0, lookz = 10.0;
float altura = 2;
float angulo = 90.0;

int startX, startY, tracking = 0;


void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

	// compute window's aspect ratio 
	float ratio = w * 1.0 / h;

	// Reset the coordinate system before modifying
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set the correct perspective
	gluPerspective(45,ratio,1,1000);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}

void loadImg() {

	ilGenImages(1, &t);
	ilBindImage(t);
	ilLoadImage((ILstring)"terreno.jpg");
	ilConvertImage(IL_LUMINANCE, IL_UNSIGNED_BYTE);
	tw = ilGetInteger(IL_IMAGE_WIDTH);
	th = ilGetInteger(IL_IMAGE_HEIGHT);
	imageData = ilGetData();




	for (int i = 0; i < th-1; i++) {   //carregar os pontos para um vector
		for (int j = 0; j < tw; j++) {
			Ponto  p1;
			Ponto  p2;

			p1.x =  j;
			p1.y = (imageData[i * th + j  ]) / 3.0;
			if (i == 0) {
				float a = (imageData[i * th + j]) / 3.0;
				alturas.push_back(a);
			}
			p1.z =  i;

			p2.x =  j;
			p2.y = (imageData[(i + 1) * tw + j]) / 3.0;
			p2.z = i + 1;
			float b = (imageData[i * th + j]) / 3.0;
			alturas.push_back(b);

			pontos.push_back(p1);
			pontos.push_back(p2);
		}
	}

	glEnableClientState(GL_VERTEX_ARRAY);
	glGenBuffers(1, buffers);
	glBindBuffer(GL_ARRAY_BUFFER, buffers[0]);
	glBufferData(GL_ARRAY_BUFFER, (pontos.size() * sizeof(Ponto)), &pontos.front(), GL_STATIC_DRAW);


}

void drawTerrain() {
	glVertexPointer(3, GL_FLOAT, 0, 0);
	glColor3f(1.0, 1.0, 1.0);

	glPushMatrix();
	glTranslatef(-(tw / 2.0), 0, -(th / 2.0));

	for (int i = 0; i < th ; i++) {
		glDrawArrays(GL_TRIANGLE_STRIP, i*tw*2, 2*th);
	}
	
	glPopMatrix();


}

float h(int x, int z) {
	
	return	alturas.at(z * 256 + x );
}

float hf(float px, float pz) {

	int x1 = floor(px); int x2 = x1 + 1;
	int z1 = floor(pz); int z2 = z1 + 1;

	float fz = pz - z1;
	float fx = px - x1;

	float h_x1_z = h(x1, z1) * (1 - fz) + h(x1, z2) * fz;
	float h_x2_z = h(x2, z1) * (1 - fz) + h(x2, z2) * fz;

	float height_xz = (h_x1_z * (1 - fx) + h_x2_z * fx) ;

	return height_xz;
}

void drawTrees() {
	srand(arvore);
	arvore++;
	float x, y, z, dist, alt;

	do {
		alt = rand() % 2;
		x = (rand() % ((tw-2)*100))/ 100 - floor((tw - 2) / 2);
		z = (rand() % ((th-2)*100))/ 100 - floor((th - 2) / 2);
		y =  hf((x +(tw / 2)), (z + (th / 2)));
		dist = x * x + z * z;
	} while (sqrt(dist) < 50);
	glPushMatrix();
	glTranslatef(x, y, z);
	glRotatef(270, 1, 0, 0);
	glColor3f(0.7, 0.5, 0);
	glutSolidCone(0.2, 3 + 8 + alt, 20, 10);

	glTranslatef(0, 0, 3);

	glColor3f(0.3f, 0.9f, 0.3f);

	glutSolidCone(1.7f, 8 + alt, 8, 5);



	glPopMatrix();


};

void drawTeaPots() { //red teapots
	float piinc = (2 * M_PI) / 16;
	float miniinc = (2 * M_PI) / (16 * 30);
	for (int i = 0; i <= 16; i++) {
		glPushMatrix();
		glRotatef(180, 0, 1, 0);
		glColor3f(1.0f, 0.0f, 0.0f);
		float angulo = piinc * i + time * miniinc;
		glTranslatef(  35 * sin(angulo),               0.75 +h(35 * sin(angulo)+(tw/2), 35 * cos(angulo)+(th/2)),           35 * cos(angulo));
		glRotatef(22.5 * i + (0.75 * time), 0, 1, 0);
		glutSolidTeapot(1);
		glPopMatrix();
	}

	float piincc = (2 * M_PI) / 8;
	float miniincc = (2 * M_PI) / (8 * 30);
	for (int ii = 0; ii <= 8; ii++) { //blue
		glPushMatrix();
		glRotatef(90, 0, 1, 0);
		glColor3f(0.0f, 0.0f, 1.0f);
		float angulo = piincc * ii + time * miniincc;
		glTranslatef(15 * sin(-angulo), 0.75, 15 * cos(-angulo));
		glRotatef(-90 - (45.0 * ii + (1.5 * time)), 0, 1, 0);
		glutSolidTeapot(1);
		glPopMatrix();
	}

}

void drawDonut() {
	glColor3f(1.0f, 0.0f, 1.0f);
	glutSolidTorus(1, 2.2, 25, 25);

}

void renderScene(void) {
	arvore = 0;

	float pos[4] = {-1.0, 1.0, 1.0, 0.0};

	glClearColor(0.0f,0.0f,0.0f,0.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glLoadIdentity();
	gluLookAt(camX, camY, camZ, 
		      lookx,looky,lookz,
			  0.0f,1.0f,0.0f);

	drawTerrain();

	for (int i = 0; i < 600; i++) {
		drawTrees();
	}
	time++;
	drawTeaPots();
	drawDonut();
	// just so that it renders something before the terrain is built
	// to erase when the terrain is ready
	//glutWireTeapot(2.0);

// End of frame
	glutSwapBuffers();
}

void processKeys(unsigned char c, int xx, int yy) {

	switch (c) {

	case 'd':
		camX = camX + 1 * sin(angulo - 90);
		camZ = camZ + 1 * cos(angulo - 90);
		break;

	case 'a':
		camX = camX - 1 * sin(angulo - 90);
		camZ = camZ - 1 * cos(angulo - 90);
		break;

	case 'w':
		camX = camX + 1 * sin(angulo);
		camZ = camZ + 1 * cos(angulo);
		break;

	case 's':
		camX = camX - 1 * sin(angulo);
		camZ = camZ - 1 * cos(angulo);
		break;

	case 'q': 
		angulo += 0.05;
		break;

	case 'e': 
		angulo -= 0.05;
		break;
	}

	camY = h(camX+(tw/2), camZ+(tw / 2)) + altura;

	lookx = camX + sin(angulo);
	looky = camY;
	lookz = camZ + cos(angulo);

	glutPostRedisplay();

}
/*
void processMouseButtons(int button, int state, int xx, int yy) {
	
	if (state == GLUT_DOWN)  {
		startX = xx;
		startY = yy;
		if (button == GLUT_LEFT_BUTTON)
			tracking = 1;
		else if (button == GLUT_RIGHT_BUTTON)
			tracking = 2;
		else
			tracking = 0;
	}
	else if (state == GLUT_UP) {
		if (tracking == 1) {
			alpha += (xx - startX);
			beta += (yy - startY);
		}
		else if (tracking == 2) {
			
			r -= yy - startY;
			if (r < 3)
				r = 3.0;
		}
		tracking = 0;
	}
}

void processMouseMotion(int xx, int yy) {

	int deltaX, deltaY;
	int alphaAux, betaAux;
	int rAux;

	if (!tracking)
		return;

	deltaX = xx - startX;
	deltaY = yy - startY;

	if (tracking == 1) {


		alphaAux = alpha + deltaX;
		betaAux = beta + deltaY;

		if (betaAux > 85.0)
			betaAux = 85.0;
		else if (betaAux < -85.0)
			betaAux = -85.0;

		rAux = r;
	}
	else if (tracking == 2) {

		alphaAux = alpha;
		betaAux = beta;
		rAux = r - deltaY;
		if (rAux < 3)
			rAux = 3;
	}
	camX = rAux * sin(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
	camZ = rAux * cos(alphaAux * 3.14 / 180.0) * cos(betaAux * 3.14 / 180.0);
	camY = rAux * 							     sin(betaAux * 3.14 / 180.0);
}
*/

void init() {

// 	Load the height map "terreno.jpg"

// 	Build the vertex arrays

// 	OpenGL settings
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);
}

int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(320,320);
	glutCreateWindow("CG@DI-UM");
		

// Required callback registry 
	glutDisplayFunc(renderScene);
	glutIdleFunc(renderScene);
	glutReshapeFunc(changeSize);

// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	//glutMouseFunc(processMouseButtons);
	//glutMotionFunc(processMouseMotion);
	init();	


// our code
	glewInit();
	ilInit();
	loadImg();
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	processKeys('k',1,1);
	printf("WASD mexe a camera\nQ E roda a camara\n");
// enter GLUT's main cycle
	glutMainLoop();
	
	return 0;
}


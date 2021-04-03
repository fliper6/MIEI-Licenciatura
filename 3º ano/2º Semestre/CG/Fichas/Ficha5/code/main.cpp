#include <stdio.h>
#include <stdlib.h>
#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>

int arvore=0;
float alfa = 0.0f, beta = 0.5f, radius = 100.0f;
float camX, camY, camZ;
int time = 0;
bool left, right;
float mouseXPos, mouseYPos;

void spherical2Cartesian() {

	camX = radius * cos(beta) * sin(alfa);
	camY = radius * sin(beta);
	camZ = radius * cos(beta) * cos(alfa);
}

void changeSize(int w, int h) {

	// Prevent a divide by zero, when window is too short
	// (you cant make a window with zero width).
	if(h == 0)
		h = 1;

	// compute window's aspect ratio 
	float ratio = w * 1.0 / h;

	// Set the projection matrix as current
	glMatrixMode(GL_PROJECTION);
	// Load Identity Matrix
	glLoadIdentity();
	
	// Set the viewport to be the entire window
    glViewport(0, 0, w, h);

	// Set perspective
	gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

	// return to the model view matrix mode
	glMatrixMode(GL_MODELVIEW);
}

void drawTrees() {
	srand(arvore);
	arvore++;
	float x, y, z,dist,alt;

	do {
		alt = rand() % 2;
		x = (rand() % 200) - 100;
		y = 0;
		z = (rand() % 200) - 100;
		dist = x * x + z * z;
	} while (sqrt(dist)<50);
	glPushMatrix();


		glTranslatef(x, 0, z);
		glRotatef(270, 1, 0, 0);
		glColor3f(0.7, 0.5, 0);
		glutSolidCone(0.2, 3 + 8 + alt, 20, 10);

		glTranslatef(0, 0, 3);

		glColor3f(0.3f, 0.9f, 0.3f);

		glutSolidCone(1.7f, 8+alt, 5, 1);



	glPopMatrix();

	
};

void drawTeaPots() { //red teapots
	float piinc = (2 * M_PI) / 16;
	float miniinc = (2 * M_PI) / (16*30);
	for (int i =0; i<=16;i++){
	glPushMatrix();
		glRotatef(180, 0 , 1, 0);
		glColor3f(1.0f, 0.0f, 0.0f);
		float angulo = piinc * i + time * miniinc;
		glTranslatef(35*sin(angulo), 0.75, 35*cos(angulo));
		glRotatef(22.5*i + (0.75 * time), 0, 1, 0);
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
		glRotatef(-90-(45.0 * ii + (1.5 * time)), 0, 1, 0);
		glutSolidTeapot(1);
		glPopMatrix();
	}

}

void 	drawDonut() {
	glColor3f(1.0f, 0.0f, 1.0f);
	glutSolidTorus(1, 2.2, 25, 25);


}

void renderScene(void) {
	arvore = 0;
	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(camX, camY, camZ,
		0.0, 0.0, 0.0,
		0.0f, 1.0f, 0.0f);

	glColor3f(0.2f, 0.8f, 0.2f);
	glBegin(GL_TRIANGLES);
		//chão
		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);

		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);
		glVertex3f(100.0f, 0, 100.0f);
	glEnd();

	for (int i = 0; i < 600; i++) {
		drawTrees();
	}
	drawTeaPots();
	drawDonut();
	time++;

	// End of frame
	glutSwapBuffers();
}

void processKeys(unsigned char c, int xx, int yy) {

	switch (c) {

	case 'd':
		alfa -= 0.05; break;

	case 'a':
		alfa += 0.1; break;

	case 'w':
		beta += 0.03f;
		if (beta > 1.5f)
			beta = 1.5f;
		break;

	case 's':
		beta -= 0.03f;
		if (beta < -1.5f)
			beta = -1.5f;
		break;

	case 'q': radius -= 5.0f;
		if (radius < 1.0f)
			radius = 1.0f;
		break;

	case 'e': radius += 5.0f; 
		break;
	}
	spherical2Cartesian();
	glutPostRedisplay();

}

void processSpecialKeys(int key, int xx, int yy) {

	switch (key) {

	case GLUT_KEY_RIGHT:
		alfa -= 0.1; break;

	case GLUT_KEY_LEFT:
		alfa += 0.1; break;

	case GLUT_KEY_UP:
		beta += 0.1f;
		if (beta > 1.5f)
			beta = 1.5f;
		break;

	case GLUT_KEY_DOWN:
		beta -= 0.1f;
		if (beta < -1.5f)
			beta = -1.5f;
		break;

	case GLUT_KEY_PAGE_DOWN: radius -= 1.0f;
		if (radius < 1.0f)
			radius = 1.0f;
		break;

	case GLUT_KEY_PAGE_UP: radius += 1.0f; break;
	}
	spherical2Cartesian();
	glutPostRedisplay();

}

void printInfo() {

	printf("Vendor: %s\n", glGetString(GL_VENDOR));
	printf("Renderer: %s\n", glGetString(GL_RENDERER));
	printf("Version: %s\n", glGetString(GL_VERSION));

	printf("\nWASD para mover a camara\n");
	printf("QE para Zoom in/out\n");
}

int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
	glEnableClientState(GL_VERTEX_ARRAY);
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutIdleFunc(renderScene);
	// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);
//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);

	spherical2Cartesian();

	printInfo();

// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}

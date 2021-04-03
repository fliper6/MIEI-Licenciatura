#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <math.h>
float a=0, b=0;
float camX = 10, camY =0, camZ=0;


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


void drawCylinder(float radius, float height, int slices) {
	float ang = 2*M_PI / slices;
	glColor3f(1.0f, 1.0f, 1.0f);
	glBegin(GL_TRIANGLES);
	for (int i = 0; i < slices; i++) { 
		//base de baixo

		float x1 = radius * cos(ang * (i+0.0));
		float z1 = radius * sin(ang * (i+0.0));

		glVertex3f(x1, 0.0f, -z1);
		glVertex3f(0.0f, 0.0f, 0.0f); //ponto no centro

		float x2 = radius * cos(ang * (i+1.0));
		float z2 = radius * sin(ang * (i+1.0));
		glVertex3f(x2, 0.0f, -z2);


		//base de cima
		glVertex3f(0.0f, height, 0.0f); //ponto no centro
		float xx1 = radius * cos(ang * (i + 0.0));
		float zz1 = radius * sin(ang * (i + 0.0));

		glVertex3f(xx1, height, -zz1);

		float xx2 = radius * cos(ang * (i + 1.0));
		float zz2= radius * sin(ang * (i + 1.0));
		glVertex3f(xx2, height, -zz2);

		//laterais destes 2 trianguls
		
		glVertex3f(x1, 0.0f, -z1);
		glVertex3f(x2, 0.0f, -z2);
		glVertex3f(xx1, height, -zz1);

		glVertex3f(xx2, height, -zz2);
		glVertex3f(xx1, height, -zz1);
		glVertex3f(x2, 0.0f, -z2);







	}
	glEnd();
// put code to draw cylinder in here

}


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(camX,camY+1,camZ, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

	drawCylinder(1,2,35);

	// End of frame
	glutSwapBuffers();
}


void processKeys(unsigned char c, int xx, int yy) {

	switch (c) {
	case 'w':
		if(b <=1.5) b += 0.1;
		break;
	case 's':
		if(b >= -1.5) b -= 0.1;
		break;
	case 'a':
		if (a >= -1.5) a -= 0.1;
		break;
	case 'd':
		if (a <= 1.5) a += 0.1;
		break;
	}
	camX = 10 * cos(b) * sin(a);
	camY = 10 * sin(b);
	camZ = 10 * cos(b) * cos(a);
	glutPostRedisplay();
}


void processSpecialKeys(int key, int xx, int yy) {

// put code to process special keys in here

}


int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	
// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}

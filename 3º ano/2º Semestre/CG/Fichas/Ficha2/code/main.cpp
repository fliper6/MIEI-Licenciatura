#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <math.h>

float tx = 0.0, ty = 0.0, tz = 0.0;
float /*rx = 0.0, ry = 0.0, rz = 0.0*/ rangle = 0.0;
float scale = 1.0;

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


void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(5.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

	// put drawing instructions here
	glBegin(GL_LINES);
		// X axis in red
		glColor3f(1.0f, 0.0f, 0.0f);
		glVertex3f(-100.0f, 0.0f, 0.0f);
		glVertex3f(100.0f, 0.0f, 0.0f);
		// Y Axis in Green
		glColor3f(0.0f, 1.0f, 0.0f);
		glVertex3f(0.0f, -100.0f, 0.0f);
		glVertex3f(0.0f, 100.0f, 0.0f);
		// Z Axis in Blue
		glColor3f(0.0f, 0.0f, 1.0f);
		glVertex3f(0.0f, 0.0f, -100.0f);
		glVertex3f(0.0f, 0.0f, 100.0f);
	glEnd();

	/* Se pusermos as transformacões geométricas antes de desenhar os eixos, eles 
	   é também se vão deslocar (neste caso, só a pirâmmide é que se move)*/

	// put the geometric transformations here
	glTranslatef(tx, ty, tz);
	glRotatef(rangle, 0.0, 1.0, 0.0);
	glScalef(scale, scale, scale);

	/* A ordem dos pontos é importante (regra da mão direita) para saber que
    faces é que estão visiveis (na perspetiva em que inicializei a pirâmide)*/

	glBegin(GL_TRIANGLES);
		glColor3f(0.0f, 0.0f, 1.0f);
		glVertex3f(0.0f, 2.0f, 0.0f);
		glVertex3f(-2.0f, 0.0f, 0.0f);
		glVertex3f(0.0f, 0.0f, 0.0f);
		
		glColor3f(1.0f, 0.0f, 1.0f);	
		glVertex3f(0.0f, 0.0f, 0.0f);
		glVertex3f(0.0f, 0.0f, -2.0f);
		glVertex3f(0.0f, 2.0f, 0.0f);
		
		glColor3f(1.0f, 0.0f, 0.0f);
		glVertex3f(0.0f, 2.0f, 0.0f);
		glVertex3f(0.0f, 0.0f, -2.0f);
		glVertex3f(-2.0f, 0.0f, 0.0f);
		
		glColor3f(1.0f, 0.5f, 0.0f);
		glVertex3f(0.0f, 0.0f, -2.0f);
		glVertex3f(0.0f, 0.0f, 0.0f);
		glVertex3f(-2.0f, 0.0f, 0.0f);
	glEnd();

	// End of frame
	glutSwapBuffers();
}

// write function to process keyboard events
void wasd(unsigned char tecla, int x, int y) {
	switch (tecla) {
	case 'w':
		tz -= 1;
		break;
	case 's':
		tz += 1;
		break;
	case 'a':
		tx -= 1;
		break;
	case 'd':
		tx += 1;
		break;
	case 'e':
		rangle -= 5;
		break;
	case 'q':
		rangle += 5;
		break;
	case 'z':
		scale += 0.1;
		break;
	case 'x':
		scale -= 0.1;
		break;
	}
	glutPostRedisplay();
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

	
// put here the registration of the keyboard callbacks
	glutKeyboardFunc(wasd);
	//glutSpecialFunc(keyboard_registry);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
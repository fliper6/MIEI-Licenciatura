#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "person.h"

int main() {

	Person hugo = new_person("Hugo",19);
	printf ("%s %d\n", hugo.nome, hugo.idade);

	Person hugo2 = clone_person(&hugo);
	printf ("%s %d\n", hugo2.nome, hugo2.idade);
	printf ("%d\n", person_age(&hugo));

	person_change_age(&hugo,35);
	printf ("%d\n", person_age(&hugo));

	return 0;
}
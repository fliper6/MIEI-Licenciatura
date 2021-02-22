#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "person.h"
/*
Person new_person (char* name, int age) {
	size_t n = strlen(name) + 1; //comprimento da string + \0
	char* nome = malloc(sizeof(char[n]));
	memcpy(nome,name,n);

	Person novo;
	novo.nome = nome;
	novo.idade = age;
	return novo;
}*/

//O objetivo é nunca declarar uma variável sem a inicializar
//daí inicializar os campos no próprio return
Person new_person (char* name, int age) {
	return (Person) {
		.nome = strdup(name),
		.idade = age,
	};
}
/*
Person clone_person (Person* p) {
	Person clone;
	size_t n = strlen(p->nome) + 1;
	char* nome = malloc(sizeof(char[n]));
	memcpy(nome,p->nome,n);

	clone.nome = nome;
	clone.idade = p->idade;
	return clone;
}*/

Person clone_person (Person* p) {
	return (Person) {
		.nome = strdup(p->nome), //
		.idade = p->idade,
	};
}

void destroy_person(Person* p) {
	free (p->nome); //o nome é a única parte da struct que aloca memória
}

int person_age(Person* p) {
	return p->idade;
}

void person_change_age(Person* p, int age) {
	p->idade = age;
}
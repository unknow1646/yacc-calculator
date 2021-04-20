/*************************************************************************************************/
/**
 * \author Gina Ozimisa, Hernan Diaz
 * \date Mayo-2019
 Objetivo: Diseñar tabla de verdad a traves de una matriz axb donde a=(2^variables)/8 y
 b=variables+operaciones usando bits.
*/

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

    typedef struct ElementoLista
    {
        char *dato; //cada elemento de la lista contendra un string
        struct ElementoLista *siguiente;
    } Element;

    typedef struct ListaIdentificar
    {
        Element *inicio; //primer elemento de la lista
        Element *fin; //ultimo elemento de la lista
        int tamano;//cantidad de elementos en la lista
    } Lista;


        /****************FUNCIONES*****************/

        void inicializacion (Lista *lista)
        {
            lista->inicio = NULL;
            lista->fin = NULL;
            lista->tamano = 0;
        }

        /* inserción en una lista vacía */

        int ins_en_lista_vacia (Lista * lista, char *dato)
        {

            Element *nuevo_elemento;
            if ((nuevo_elemento = (Element *) malloc (sizeof (Element))) == NULL)
                return -1;
            if ((nuevo_elemento->dato = (char *) malloc (50 * sizeof (char))) == NULL)
                return -1;
            strcpy (nuevo_elemento->dato, dato);
            nuevo_elemento->siguiente = NULL;
            lista->inicio = nuevo_elemento;
            lista->fin = nuevo_elemento;
            lista->tamano++;
            return 0;
        }

        /*inserción al final de la lista */

        int ins_fin_lista (Lista * lista, Element * actual, char *dato)
        {
            Element *nuevo_elemento;
            if ((nuevo_elemento = (Element *) malloc (sizeof (Element))) == NULL)
                return -1;
            if ((nuevo_elemento->dato = (char *) malloc (50 * sizeof (char)))== NULL)
                return -1;
            strcpy (nuevo_elemento->dato, dato);
            actual->siguiente = nuevo_elemento;
            nuevo_elemento->siguiente = NULL;
            lista->fin = nuevo_elemento;
            lista->tamano++;
            return 0;
        }


        /* visualización de la lista */

        void visualizacion (Lista * lista)
        {

            Element *actual;
            actual = lista->inicio;
            while (actual != NULL)
            {
                printf ("%s ", actual->dato);
                actual = actual->siguiente;
            }
            printf(" ");
        }

        /* elimina el ultimo elemento de la lista y retorna el dato que contenia */

        char *pop(Lista *lista)
        {
            char *dat;
            Element *actual=lista->inicio;
            Element *elemento=lista->fin;
            dat = lista->fin->dato;
            if(actual->siguiente!=NULL)
            {
                while(actual->siguiente->siguiente!=NULL)
                    actual=actual->siguiente;
            }
            lista->fin=actual;
            actual->siguiente=NULL;
            free(elemento);
            return dat;
        }

        /*inserción al final de la lista de una lista vacia o llena*/

        void insertar(char *algo,Lista *lista)
        {
            if (lista->tamano == 0)
                ins_en_lista_vacia (lista, algo);
            else
                ins_fin_lista (lista,lista->fin,algo);
        }

        /*comprueba si esta un string en una lista*/

        bool esta(char *algo, Lista *lista)
        {
            Element *actual;
            actual = lista->inicio;
            while (actual != NULL)
            {
                if(strcmp(actual->dato,algo)==0)
                    return true;
                actual = actual->siguiente;
            }
            return false;
        }

        /*devuelve la posicion en la que esta el elemento*/

        int indice(char *algo, Lista *lista)
        {
            int i=0;
            Element *actual;
            actual = lista->inicio;
            while (actual != NULL)
            {
                if(strcmp(actual->dato,algo)==0)
                    return i;
                i++;
                actual = actual->siguiente;
            }
            return false;
        }

        /*devuelve un numero elevado al exponente */

        int potencia (int num, int exp)
        {
            int i,aux=1;
            for(i=0; i<exp; i++)
                aux=aux*num;
            return aux;
        }

        /*transforma un char a string*/
        char *char_to_string(char letra)
        {
            char *str;
            str=calloc(2,sizeof(char));
            str[0]=letra;
            str[1]='\0';
            return str;
        }

        /* Listas */
        Lista *marked;
        Lista *lista;

        char *aux;
%}

%token NUMBER
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%%

ArithmeticExpression: E{

         printf("\nResultado=%d\n",$$);

         return 0;

        };
E:E'+'E {$$=suma(convertBinaryToDecimal($1),convertBinaryToDecimal($3));}
 |E'-'E {$$=resta(convertBinaryToDecimal($1),convertBinaryToDecimal($3));}
 |E'*'E {$$=multiplicacion(convertBinaryToDecimal($1),convertBinaryToDecimal($3));}
 |E'/'E {$$=division(convertBinaryToDecimal($1),convertBinaryToDecimal($3));}
 |'('E')' {$$=$2;}
 | NUMBER {$$=$1;}
;

%%

/* PRÁCTICA 1 */

/* apartado A */

proc format /* library = sasuser.formatos_practica_15_ */;

/* estado de ánimo más frecuente */
value pregunta_3_  1 = 'Contento, tranquilo, satisfecho'
				   2 = 'Solo, solitario, aislado'
				   3 = 'Aburrido'
				   4 = 'Cansado, con estrés, nervioso '
				   5 = 'Deprimido, triste'
				   6 = ' Eufórico, lleno de vitalidad, entusiasmado '
				   7 = 'Preocupado por algo '
				   9 = 'No sabe/No contesta ';
				  

/* Espacio geográfico con el que se siente más identificado */
value pregunta_10_ 1 = 'Su pueblo o ciudad '
				   2 = ' Su provincia '
				   3 = 'Su Comunidad Autónoma '
				   4 = 'España '
				   5 = ' Europa '
				   6 = ' Occidente '
				   7 = 'El Mundo  '
				   8 = ' Ninguno'
				   9 = 'No sabe/No contesta';

/* Tipo de música preferido */
value pregunta_22_  01 = 'Música Clásica/Opera'
                    02 = 'Canción Española'
                    03 = 'Salsa/Merengue'
                    04 = 'Jazz/Blues'
                    05 = 'Flamenco'
                    06 = 'Música de cantautores'
                    07 = 'Música ligera'
                    08 = 'Rock'
                    09 = 'Música disco'
                    10 = 'Pop'
                    11 = 'Zarzuela'
                    12 = 'Otros ¿cuál?'
                    13 = 'Depende de cada momento, no tengo un tipo definido'
                    14 = 'Ninguno'
                    15 = 'No sabe/No contesta';

/* Tipo de programa TV preferido */
value pregunta_24_  01 = 'Informativos '
                    02 = ' Películas '
                    03 = ' Documentales '
                    04 = 'Programas de variedades'
                    05 = ' Concursos'
                    06 = 'Obras de teatro'
                    07 = ' Culturales '
                    08 = 'Programas sobre temas de actualidad '
                    09 = ' Telenovelas'
                    10 = 'Musicales '
                    11 = 'Deportivos '
                    12 = ' Coloquios, tertulias '
                    13 = 'Entrevistas '
                    14 = 'Series de televisión '
                    15 = 'Infantiles '
				    16 = ' Humorísticos '
                    17 = 'Otros ¿Cuales?'
                    18 = 'Todos'
                    19 = 'Ninguno'
                    20 = 'No sabe/No contesta';

/* Grado importacia Fundaciones en la cultura */
value pregunta_41_ 1 = 'Nada importante'
                   2 = 'Poco importante'
                   3 = 'Bastante importante'
                   4  =  'Muy importante'
                   9 = 'No sabe/No contesta';

/*  Realización de promoción de la cultura */
value pregunta_42_ 1 = 'Debe ser realizada en exclusiva por el Gobierno'
                   2 = 'Debe ser realizada principalmente por el Gobierno'
                   3 = 'Debe ser realizada más o menos por igual por el Gobierno y las Fundaciones'
                   4 = 'Debe ser realizada principalmente por las Fundaciones'
                   5 = 'Deber ser realizada en exclusiva por las Fundaciones'
                   9 = 'No sabe/No contesta';

/* Edad del entrevistado*/
value edad_e_10_   1 = '18 o 19 años'
				   2 = 'entre 20 y 29 años'
				   3 = 'entre 30 y 39 años'
				   4 = 'entre 40 y 49 años'
                   5 = 'entre 50 y 59 años'
                   6 = 'entre 60 y 69 años'
                   7 = 'entre 70 y 79 años'
                   8 = 'entre 80 y 89 años'
                   9 = 'entre 90 y 99 años';

value sexo_e_9_     1 = 'Varón'
                    2 = 'Mujer';
run;

                  

title'Muestreo de datos';
Data sasuser.encuesta_cires_15;
infile "C:\Users\Pablo Galaron\Downloads\cires94abril.txt" n = 5;
input #1 estado_de_animo 16  
	  #1 geografico  51      
	  #3 musica_pref  7-8      
	  #3 tv_pref   11-12          
	  #4 fundaciones_cultura  26   
      #4 prom_cultura  27 
      #5 edad  10 
	  #5 sexo  9  ;

format  estado_de_animo pregunta_3_.
        geografico  pregunta_10_.
	    musica_pref  pregunta_22_.    
	    tv_pref      pregunta_24_.  
	    fundaciones_cultura  pregunta_41_.
        prom_cultura pregunta_42_.
        edad edad_e_10_. 
		sexo sexo_e_9_. ;

run;
proc print data = sasuser.encuesta_cires_15; run;


/* a modo de comprobación del apartado a */
proc freq data = sasuser.encuesta_cires_15;
tables estado_de_animo--sexo;
run;


/* apartado B */ 

/* el enunciado no me pedía que introdujera la variable sexo pero sin ella no puedo
realizar este apartado, entonces la añadiré arriba para poder continuar */

/*Creamos la variable*/
data sasuser.encuesta_cires_15;

set sasuser.encuesta_cires_15;

length sexo_edad $ 50.;

if sexo = 1 and edad = 1 then sexo_edad = 'Varón de 18 o 19 años';
if sexo = 1 and edad = 2 then sexo_edad = 'Varón entre 20 y 29 años';
if sexo = 1 and edad = 3 then sexo_edad = 'Varón entre 30 y 39 años';
if sexo = 1 and edad = 4 then sexo_edad = 'Varón entre 40 y 49 años';
if sexo = 1 and edad = 5 then sexo_edad = 'Varón entre 50 y 59 años';
if sexo = 1 and edad = 6 then sexo_edad = 'Varón entre 60 y 69 años';
if sexo = 1 and edad = 7 then sexo_edad = 'Varón entre 70 y 79 años';
if sexo = 1 and edad = 8 then sexo_edad = 'Varón entre 80 y 89 años';
if sexo = 1 and edad = 9 then sexo_edad = 'Varón entre 90 y 99 años';


if sexo = 2 and edad = 1 then sexo_edad = 'Mujer de 18 o 19 años';
if sexo = 2 and edad = 2 then sexo_edad = 'Mujer entre 20 y 29 años';
if sexo = 2 and edad = 3 then sexo_edad = 'Mujer entre 30 y 39 años';
if sexo = 2 and edad = 4 then sexo_edad = 'Mujer entre 40 y 49 años';
if sexo = 2 and edad = 5 then sexo_edad = 'Mujer entre 50 y 59 años';
if sexo = 2 and edad = 6 then sexo_edad = 'Mujer entre 60 y 69 años';
if sexo = 2 and edad = 7 then sexo_edad = 'Mujer entre 70 y 79 años';
if sexo = 2 and edad = 8 then sexo_edad = 'Mujer entre 80 y 89 años';
if sexo = 2 and edad = 9 then sexo_edad = 'Mujer entre 90 y 99 años';

run;
proc print data = sasuser.encuesta_cires_15; run;

/* Calculamos las frecuencias que tiene cada sexo_edad con la música */
proc freq data = sasuser.encuesta_cires_15 ; 
tables sexo_edad * musica_pref / out = solucion_b;
run;

/* Ordenamos (menor a mayor por COUNT */
proc sort data = solucion_b;
by sexo_edad COUNT;
run; 

/* Cogemos el último valor de la variable(maximo de count >> favorito) */
title 'Música preferida por sexo y edad';
data musica_por_sexo_edad;
set solucion_b;
by sexo_edad;
if last.sexo_edad then output; 
keep sexo_edad musica_pref;
run;

proc print data = musica_por_sexo_edad; run; 


/* apartado C */
/* mismo prodecimiento que apartado anterior*/


proc freq data = sasuser.encuesta_cires_15 ;
tables sexo_edad * prom_cultura / out = solucion_c;
run;

proc sort data = solucion_c;
by sexo_edad COUNT;
run; 

title 'Promociones cultura por sexo y edad';
data cultura_por_sexo_edad;
set solucion_c;
by sexo_edad;
if last.sexo_edad then output; 
drop COUNT PERCENT;
run;

proc print data = cultura_por_sexo_edad; run; 



/* apartado D */
/* mismo prodecimiento que apartado anterior*/

proc freq data = sasuser.encuesta_cires_15 ;
tables sexo_edad * tv_pref / out = solucion_d;
run;

proc sort data = solucion_d;
by sexo_edad COUNT;
run; 

title 'Programa TV preferido por sexo y edad';
data tv_por_sexo_edad;
set solucion_d;
by sexo_edad;
if last.sexo_edad then output; 
drop COUNT PERCENT;
run;

proc print data = tv_por_sexo_edad; run; 



/* apartado E */

title'Unión musica_pref prom_cultura y tv_pref por sexo y edad';
data union;
merge musica_por_sexo_edad cultura_por_sexo_edad tv_por_sexo_edad;
run;
proc print data = union; run;


/* apartado F */

/* recodificamos la variable */
data recodificado;

set  sasuser.encuesta_cires_15;

length edad_2 $ 30.;

if edad = 1 or edad = 2  then edad_2 = '< de 30 años';
if edad = 3 or edad = 4  then edad_2 = 'Entre 30 y 49 años';
if edad = 5 or edad = 6  then edad_2 = 'Entre 50 y 69 años';
if edad = 7 or edad = 8 or edad = 9  then edad_2 = 'Más de 70 años';

drop edad;

run;
proc print data =  recodificado; run;


proc freq data = recodificado ;
tables edad_2 * estado_de_animo / out = solucion_f;
run;

proc sort data = solucion_f;
by edad_2 COUNT;
run; 

title "Estado de ánimo más frecuente por grupo de edad recodificado";
data animo_por_edad_2;
set solucion_f;
by edad_2;
if last.edad_2 then output; 
run;

proc print data = animo_por_edad_2; run; 



title "Estado de ánimo más frecuente por grupo de edad recodificado";
proc gchart data = animo_por_edad_2;
pie edad_2 / sumvar=COUNT 
             subgroup = estado_de_animo 
             value = inside
             percent = arrow
			 discrete 
             ;
run;


/* apartado G */


proc freq data = recodificado ;
tables edad_2 * geografico / out = solucion_g;
run;

proc sort data = solucion_g;
by edad_2 COUNT;
run; 

title "Lugar favorito por grupo de edad recodificado";
data geografico_por_edad_2;
set solucion_g;
by edad_2;
if last.edad_2 then output; 
run;

proc print data = geografico_por_edad_2; run; 



title "Lugar favorito por grupo de edad recodificado";
proc gchart data = geografico_por_edad_2;
pie edad_2 / sumvar=COUNT 
             subgroup = geografico 
             value = inside
             percent = arrow
			 discrete 
             ;
run;


/* apartado H */

proc freq data = sasuser.encuesta_cires_15 ;
tables fundaciones_cultura * tv_pref/ out = solucion_h;
run;

proc sort data = solucion_h;
by fundaciones_cultura COUNT;
run; 

title 'TV fav por fundaciones en cultura';
data tv_por_fund_cultura;
set solucion_h;
by fundaciones_cultura;
if last.fundaciones_cultura then output; 
drop COUNT PERCENT;
run;

proc print data = tv_por_fund_cultura; run; 


/* PRÁCTICA-2 Nº 24 PABLO GALARÓN MATEO */

/* APARTADO A */

proc format /*library = sasuser. formatos_practica_24_*/;

value horario  0 - 7 = 'Madrugada'
               8 - 12 = 'Mañana'
               13 - 16 = 'Mediodía'
               17 - 20 = 'Tarde'
               21 - 24 = 'Noche';

value estaciones  1 - 3 = 'Invierno'
                  4 - 6 = 'Primavera'
                  7 - 9 = 'Verano'
                  10 - 12 = 'Otoño';

run;

/* para recordar que lo hemos introducido en sas user por nuestra propia cuenta, no haría falta hacer
este paso data pero lo hago para que observemos que es lo que necesitamos, cual es nuestro conjunto de datos. */

data sasuser.contamina;
set sasuser.contamina;
run;
proc print data = sasuser.contamina (obs= 10); run; /* imprimo 10 observaciones para apreciar un poco el conjunto de datos */
 
/* APARTADO B */


proc means data = sasuser.contamina nway noprint;
var O3;
class ANNO hora mes;
output out = ej_b mean = medias_ozono;
format hora horario. 
       mes estaciones.; /* introduzco los formatos ahora que si que me hacen falta */
run;

Proc sort data = ej_b;
by hora mes;
run;

title    h = 2  color = black "Evolución media del ozono";
footnote h = 1.7  color = black "Para cada estación y horario";
symbol1 v = dot i = j color = blue; /* para el plot1 */
symbol2 w = 2   i = r color = red;  /* para el plot2 */ /*w me mide el grosor de la linea */
proc gplot data = ej_b;
by hora mes;
plot1 medias_ozono * anno /LEGEND; /* /legend es para que aparezca abajo la leyenda */
plot2 medias_ozono * anno /LEGEND;
label anno='Año' medias_ozono='Media de Ozono';/* con estos nombres queda mejor */
run;


/* APARTADO C */  

/* Lo haré con npar1way porque el Ttest no puede procesar en la sentencia class más de dos nieveles en esa variable */

proc npar1way data = sasuser.contamina wilcoxon;
var O3;
class hora;
format hora horario.;
run;

proc npar1way data = sasuser.contamina wilcoxon;
var O3;
class TIPO_AREA;
run;


/* APARTADO D */ 

data rural;
set sasuser.contamina;
if TIPO_AREA = 'RURAL';
format hora horario.
       mes  estaciones.;
run;

proc sort data = rural;
by hora mes;
run;

proc univariate data = rural;
var O3;
by hora mes;
histogram / normal lognormal exponential beta 
            gamma weibull;
run;


/* APARTADO E */ 

/* Para tipo de área urbana */
data urbana;
set sasuser.contamina;
if TIPO_AREA = 'URBANA';
format hora horario.
       mes  estaciones.;
run;

proc sort data = urbana;
by hora mes;
run;

proc univariate data = urbana;
var O3;
by hora mes;
histogram / normal lognormal exponential beta 
            gamma weibull;
run;

/*Para tipo de área suburbana */

data suburbana;
set sasuser.contamina;
if TIPO_AREA = 'SUBURBANA';
format hora horario.
       mes  estaciones.;
run;

proc sort data = suburbana;
by hora mes;
run;

proc univariate data = suburbana;
var O3;
by hora mes;
histogram / normal lognormal exponential beta 
            gamma weibull;
run;


/* APARTADO F */ 

/* PRUEBA para luego saber si lo tengo bien */
proc means data = sasuser.contamina noprint nway;
var O3;
class hora;
output out = prueba
mean = ;
format hora horario.;
run;
/* Observamos que el grupo horario es MEDIODÍA
   , nos servirá para comprobar nuestro resultado
   más adelante */

proc means data = sasuser.contamina noprint nway;
var O3;
class hora;
output out = medias
mean = medias_O3;
format hora horario.;
run;

proc means data = medias noprint;
var medias_O3;
output out = max_medias (drop = _type_ _freq_)
max = 
idgroup (max(medias_O3) out[1] (hora) = max_hora);
run;

/* Creamos el formato con las regiones */

proc freq data = sasuser.contamina;
tables comunidad;
run;

data sasuser.contamina;
    set sasuser.contamina;
    
    if comunidad in ('ASTURIAS(PRINCIPADO DE)', 'CANTABRIA', 'PAÍS VASCO', 'GALICIA', 'NAVARRA(COMUNIDAD FORAL)') then region = 'Cantábrica';
    else if comunidad in ('CATALUÑA', 'COMUNIDAD VALENCIANA', 'MURCIA (REGIÓN DE)', 'BALEARES (ISLAS)') then region = 'Mediterránea';
    else if comunidad in ('MADRID', 'CASTILLA Y LEÓN', 'CASTILLA-LA MANCHA', 'ARAGÓN', 'EXTREMADURA', 'RIOJA (LA)') then region = 'Interior';
    else region = 'Otra'; 
run;


/* Filtrar datos para el grupo horario con la mayor media de ozono---MEDIODÍA(hemos comprobado en proc means)*/
data filtrados;
set sasuser.contamina;
if hora in (13,14,15,16); /*LAS HORAS PERTENECIENTES AL MEDIODÍA */
format hora horario.;
run;

/* PASO FINAL: hacemos el proc npar1way y observamos */
proc sort data = filtrados;
by mes; 
format mes estaciones.;
run;


proc npar1way data = filtrados wilcoxon;
var O3;
class region;
by mes;
format mes estaciones.;
run;

 
/* APARTADO G */ 

proc means data = sasuser.contamina noprint nway;
var O3;
class hora region mes ANNO;
output out = medias_ozono mean = medias_O3;
format hora horario.
       mes estaciones.;
run;

data fecha_medias;
set medias_ozono;
fecha = mdy(mes,15,ANNO);
format fecha yymmdd10.; /* Aunque se pueden utilizar otros formatos para las fechas */
run;



title    h = 2  color = black "Evolución media del ozono por grupo horario";
footnote h = 1.7  color = black "Para cada tipo de región en España";

symbol1 v = dot i = j color = red l = 1 w = 2; 
symbol2 v = dot i = j color = green l = 2 w = 2; 
symbol3 v = dot i = j color = blue l = 3 w = 2;  /* DISTINTOS SYMBOLS PARA CADA REGIÓN */
symbol4 v = dot i = j color = yellow l = 4 w = 2; /* Pongo distitos tipos de líneas para que se observe mejor

proc gplot data = fecha_medias;
by hora;
plot medias_O3 * fecha = region / overlay legend ; /* Para que me saque todas las regiones en un mismo gráfico */

label fecha='Fecha';
label medias_O3='Media de Ozono';

run;


/* APARTADO H */ 

proc means data = sasuser.contamina noprint nway;
var O3;
class hora region mes ANNO;
output out = max_min_ozono max = max_O3 min = min_O3;
format hora horario.
       mes estaciones.;
run;

data fecha_max_min;
set max_min_ozono;
fecha = mdy(mes,15,ANNO);
format fecha yymmdd10.; /* Aunque se pueden utilizar otros formatos para las fechas */
run;


/* REPRESENTACIÓN PARA LOS MÁXIMOS */
title    h = 2  color = black "Evolución de los máximos niveles del ozono por grupo horario";
footnote h = 1.7  color = black "Para cada tipo de región en España";
symbol1 v = dot i = j color = red l = 1 w = 2; 
symbol2 v = dot i = j color = green l = 2 w = 2; 
symbol3 v = dot i = j color = blue l = 3 w = 2;  /* DISTINTOS SYMBOLS PARA CADA REGIÓN */
symbol4 v = dot i = j color = yellow l = 4 w = 2; 
proc gplot data = fecha_max_min;
by hora;
plot max_O3 * fecha = region / overlay legend ; /* Para que me saque todas las regiones en un mismo gráfico */
label fecha='Fecha';
label medias_O3='Max del Ozono';
run;


/* REPRESENTACIÓN PARA LOS MÍNIMOS */
title    h = 2  color = black "Evolución de los mínimos niveles del ozono por grupo horario";
footnote h = 1.7  color = black "Para cada tipo de región en España";
symbol1 v = dot i = j color = red l = 1 w = 2; 
symbol2 v = dot i = j color = green l = 2 w = 2; 
symbol3 v = dot i = j color = blue l = 3 w = 2;  /* DISTINTOS SYMBOLS PARA CADA REGIÓN */
symbol4 v = dot i = j color = yellow l = 4 w = 2; 
proc gplot data = fecha_max_min;
by hora;
plot min_O3 * fecha = region / overlay legend ; /* Para que me saque todas las regiones en un mismo gráfico */
label fecha='Fecha';
label medias_O3='Min del Ozono';
run;




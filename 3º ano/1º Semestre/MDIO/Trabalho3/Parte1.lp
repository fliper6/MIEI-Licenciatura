/* função objectivo */
min: tf ;
/* restrições */
arco_i1:   t1 >= ti + 0 ;
arco_12:   t2 >= t1 + 6 ;
arco_23:   t3 >= t2 + 7 ;
arco_3f:   tf >= t3 + 2 ;
arco_i4:   t4 >= ti + 0 ;
arco_42:   t2 >= t4 + 9 ;
arco_45:   t5 >= t4 + 9 ;
arco_53:   t3 >= t5 + 4 ;
arco_5f:   tf >= t5 + 4 ;
arco_i7:   t7 >= ti + 0 ;
arco_74:   t4 >= t7 + 6 ;
arco_78:   t8 >= t7 + 6 ;
arco_85:   t5 >= t8 + 4 ;
arco_89:   t9 >= t8 + 4 ;
arco_9f:   tf >= t9 + 2 ;
arco_i10:  t10 >= ti + 0;
arco_108:  t8 >= t10 + 8 ;
arco_1011: t11 >= t10 + 8;
arco_119:  t9 >= t11 + 7 ;
/* Atividades 1, 7 e 10 sequencialmente */
arco_101:  t1 >= t10 + 8 ;
arco_710:  t10 >= t7 + 6 ;
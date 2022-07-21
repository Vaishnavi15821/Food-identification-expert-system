% -*- mode: Prolog  -*-

% Food:) identification rules
% To run, type      go.

go :- hypothesize(Food), 
       write('I guess that food is '), 
       write(Food), nl, undo.

 /* hypotheses to be tested */ 
hypothesize(masala_rice) :- masala_rice, !. 
hypothesize(fried_rice) :- fried_rice, !. 
hypothesize(dandan_noodle) :- dandan_noodle, !. 
hypothesize(shejwan_noodle) :- shejwan_noodle, !. 
hypothesize(kabab) :- kabab, !. 
hypothesize(biryani) :- biryani, !. 
hypothesize(falafel_tikki) :- falafel_tikki, !. 
hypothesize(buttery_croissant) :- buttery_croissant, !. 
hypothesize(french_toast) :- french_toast, !. 
hypothesize(pasta) :- pasta, !. 
hypothesize(not_in_my_memory). /* no diagnosis */ 

/* food:) identification rules */ 
masala_rice :- indian, rice, 
                verify(has_sambar), 
                verify(contain_veggies). 
fried_rice :- asian, rice, 
            verify(has_varioustype_veggies), 
            verify(must_fried). 
dandan_noodle :- noodle, 
               verify(no_soup), 
               verify(china_origin). 
shejwan_noodle :- noodle, 
             verify(china_origin). 
kabab :- eastern,
               verify(use_wrap), 
               verify(contain_meat). 
biryani :- eastern, 
                 verify(contain_meat), 
                 verify(has_rice), 
                 verify(heavy_portion). 
falafel_tikki :- eastern, 
                   verify(meatballlike_shape), 
                   verify(has_veggies). 
buttery_croissant :- western, 
                   verify(pastry), 
                   verify(french_origin). 
french_toast :- western,
                    verify(bread),
                    verify(french_origin).
pasta :- western,
                 verify(taste_spicy),
                 verify(italian_origin).
/* classification rules */ 
indian :- verify(taste_spicy), !. 
asian :- verify(use_rice). 
eastern :- verify(has_meat), !. 
eastern :- verify(use_spice), 
           verify(not_spicy). 
rice :- verify(contain_carbohydrate), !. 
rice :- verify(dry_texture), 
                    verify(heavy_portion), 
                    verify(need_to_be_cooked). 
noodle :- asian, verify(stringlike_shape), !. 
noodle :- asian, verify(heavy_portion). 
western :- verify(sweet_n_savoury). 
western :- verify(contain_sauce). 


/* how to ask questions */ 
ask(Question) :- 
        write('Does the food have the following attribute: '), 
        write(Question), write('? '), 
         read(Response), nl, 
         ( (Response == yes ; Response == y) 
         -> assert(yes(Question)) ; 
         assert(no(Question)), fail). 
:- dynamic yes/1,no/1. 
/* How to verify something */ 
verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))). 

/* undo all yes/no assertions */ 
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail. 
undo. 


name "tamagochi"
org 100h

;constantes de touche de clavier
touche_gauche EQU 0x4B
touche_droite EQU 0x4D
touche_entree EQU 0x1C
;touche_esc EQU 0x1B

;constantes dimensions
LONGUEUR EQU 80
HAUTEUR_STATS EQU 4

;variables de base
age DW 1
action DW 1 ;1=normal, 2=gauche, 3=droite, 4=triste, 5=content, 6=exclamation

faim DW 5d
bonheur DW 5d
discipline DW 5d

timer DW 0d
timer_pause DW ?
timer_div100 DW 0d
mort_now dw 0d


menu_selection DW 1d
type_menu DW 1d ;1=main menu 2=food menu 3=play menu

refus DW ? ;0=accepte l'action, 1=refuse l'action
justification_reprimander DW 0d ;0=non justifie, 1=justifie


;Set the video mode to 80x25, 16 colors, 8 pages
mov ah, 0x00
mov al, 0x03
int 0x10

mov ah, 0x01
mov ch, 32
int 0x10

mov ax, 0x1003
mov bx, 0
int 0x10
;fin set video mode
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            ;;
;;            INTRO           ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;              
mov ah, 02h
mov dl, 38
mov dh, 8
int 10h

MOV AH, 09h
MOV DX, OFFSET oeuf
INT 21h

mov ah, 02h
mov dl, 10
mov dh, 20
int 10h

MOV AH, 09h
MOV DX, OFFSET intro1
INT 21h

;attend une touche pour la suite
pusha
mov ah, 0h
int 16h
popa 

CALL effacer_bestiole

mov ah, 02h
mov dl, 38
mov dh, 8
int 10h

MOV AH, 09h
MOV DX, OFFSET oeuf_c
INT 21h

mov ah, 02h
mov dl, 30
mov dh, 20
int 10h

MOV AH, 09h
MOV DX, OFFSET intro2
INT 21h

;attend une touche pour la suite
pusha
mov ah, 0h
int 16h
popa 
    
CALL effacer_bestiole    
    
mov ah, 02h
mov dl, 38
mov dh, 8
int 10h

MOV AH, 09h
MOV DX, OFFSET nouveau_ne
INT 21h

mov ah, 02h
mov dl, 0
mov dh, 20
int 10h

MOV AH, 09h
MOV DX, OFFSET intro3
INT 21h

;attend une touche pour la suite
pusha
mov ah, 0h
int 16h
popa
     
JMP start
oeuf DB 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 32, 32, 32, 32, 32, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 32, 32, 32, 32, 32, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 36
oeuf_c DB 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 32, 32, 32, 32, 32, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 219, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 32, 219, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 32, 219, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 219, 219, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 32, 219, 32, 32, 32, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 32, 32, 32, 32, 32, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 36
nouveau_ne DB 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 219, 219, 219, 219, 219, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 219, 32, 219, 219, 219, 32, 219, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 219, 219, 219, 32, 219, 219, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 219, 32, 32, 219, 32, 32, 32, 219, 219, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 219, 32, 32, 32, 32, 32, 219, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 32, 32, 219, 219, 219, 219, 219, 32, 32, 10, 8, 8, 8, 8, 8, 8, 8, 8, 8, 36
intro1 DB "Oh ! Mais qu'est-ce que c'est ? ",128,"a ressemble ",133,"... un oeuf !$"
intro2 DB "J'ai l'impression que ",128,"a bouge !$"
intro3 DB '"Maman !" - Oops, je sais pas quelle b',136,'tise tu viens de faire, mais on dirait bien qu',39,'il va falloir que tu t',39,'en occupes$'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            ;;
;;        FIN    INTRO        ;;
;;                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start:
CALL effacer_bestiole                   
    ;; FIN INTRO ;;
    

CALL afficher_cadre
CALL afficher_interface
CALL bestiole_face
CALL afficher_stats

;;;;;;;;;;;;;;;;;;;;;;;
;; BOUCLE PRINCIPALE ;;
;                     ;
boucle:
     
    CMP mort_now, 1
    JNE non_mort
        RET
    non_mort: 
    ;;;;;;;;;;;;;;;;;;;;
    ;;  TEST CLAVIER  ;;
    ;                  ;
    
    mov ah, 1h
    int 16h                 
                 
    JE pasdetouchetappe
    ;si une touche est tappee
    
    ;on vide tout de suite le buffer clavier et on recupere la touche
    mov ah, 0h
    int 16h
       
    CMP type_menu, 1
    JNE pas_menu_1
        CALL main_menu
    pas_menu_1:
    
    CMP type_menu, 2
    JNE pas_menu_2
        CALL food_menu
    pas_menu_2:
    
    CMP type_menu, 3
    JNE pas_menu_3
        CALL play_menu
    pas_menu_3:
       
         

    pasdetouchetappe:
    ;                      ;
    ;;  FIN TEST CLAVIER  ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;
    ;; GESTION DU TEMPS ;;
    ;                    ;
    
    inc timer
    
    CMP timer, 100d
    JNE non_inc_time
        add timer_div100, 1
        mov timer, 0 
         
            ;; test du temps passe ;; 
            
        ;division    
        mov ax, timer_div100
        shr ax, 1    
        JNB impair
            inc faim
            CALL afficher_barres_stats
        impair:
        mov ax, timer_div100
        shr ax, 2    
        JNB autre1
            dec bonheur
            CALL afficher_barres_stats
        autre1:
        mov ax, timer_div100
        shr ax, 3    
        JNB autre2
            dec discipline
            CALL afficher_barres_stats
        autre2:
        cmp timer_div100, 5
        JNE timer_div_pas_5
            mov age, 2
            CALL effacer_bestiole
            CALL bestiole_face
        timer_div_pas_5:
        cmp timer_div100, 10
        JNE timer_div_pas_10
            mov age, 3
            CALL effacer_bestiole
            CALL bestiole_face
        timer_div_pas_10:
        cmp timer_div100, 15
        JNE timer_div_pas_15
            mov age, 4
            CALL effacer_bestiole
            CALL bestiole_face
        timer_div_pas_15:
        
        
        ;mov ax, timer_div100
;        shr ax, 4    
;        JNB autre3
;            cmp age,4
;            JE autre3
;                inc age
;                CALL effacer_bestiole
;                CALL bestiole_face
        autre3:                        
            
            ;; fin test du temps passe ;; 
            
    non_inc_time:
                   
    ;                        ;
    ;; FIN GESTION DU TEMPS ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;               
        
JMP boucle


main_menu PROC
    
    ;; selection main_menu ;;
    
    CMP ah, touche_gauche
        JNE pas_gauche
            dec menu_selection
            
            CMP menu_selection, 1
            JNL sup_1
                mov menu_selection, 3
            sup_1:
            
            CALL afficher_interface
            
        pas_gauche:
        
    CMP ah, touche_droite
        JNE pas_droite
            inc menu_selection
            
            CMP menu_selection, 3
            JNG inf_3
                mov menu_selection, 1
            inf_3:            
            
            CALL afficher_interface
        pas_droite:
    
                       
                       
    ;; touche entree ;;
        
    CMP ah, touche_entree
        JNE pas_entree
            
                    ;; [nourrir] ;;
            
            CMP menu_selection, 1
            JNE pas_nourrir  
            
                MOV type_menu, 2 ;on change de menu
 
                CALL test_discipline
                                
                ;on efface;
                ;positionnement du curseur
                mov ah, 02h
                mov dl, 0
                mov dh, 23
                int 10h
                ;ecriture message
                MOV AH, 09h
                MOV DX, OFFSET effacer_interface
                INT 21h 
                
                CALL afficher_interface ;on rafraichi l'interface menu
            pas_nourrir:
            
            CMP menu_selection, 2
            JNE pas_jouer
            
                    ;; [jouer] ;;
                
                MOV type_menu, 3 ;on change de menu
                MOV menu_selection, 1 ;on se met a la selection par defaut
                ;on initialise timer_pause qui va servir au random
                mov cx, timer
                mov timer_pause, cx
                
                CALL test_discipline
                
                ;on efface;
                ;positionnement du curseur
                mov ah, 02h
                mov dl, 0
                mov dh, 23
                int 10h
                ;ecriture message
                MOV AH, 09h
                MOV DX, OFFSET effacer_interface
                INT 21h 
                
                CALL afficher_interface ;on rafraichi l'interface menu
                
            pas_jouer:

            CMP menu_selection, 3
            JNE pas_reprimander
            
                    ;; [reprimander] ;;
            
                CALL action_reprimander
            pas_reprimander:
            
        pas_entree:        

RET
main_menu ENDP

food_menu PROC
    
    ;; selection food menu ;;
    
    CMP ah, touche_gauche
        JNE pas_gauche_food
            dec menu_selection
            
            CMP menu_selection, 1
            JNL sup_1_food
                mov menu_selection, 3
            sup_1_food:
            
            CALL afficher_interface
            
        pas_gauche_food:
        
    CMP ah, touche_droite
        JNE pas_droite_food
            inc menu_selection
            
            CMP menu_selection, 3
            JNG inf_3_food
                mov menu_selection, 1
            inf_3_food:            
            
            CALL afficher_interface
        pas_droite_food: 
        
    
    ;; touche entree ;;
        
    CMP ah, touche_entree
        JNE pas_entree_food
            
            CMP menu_selection, 1
            JNE pas_gouter
                CALL action_gouter
                JMP pas_entree_food
            pas_gouter:
            
            CMP menu_selection, 2
            JNE pas_repas
                CALL action_repas
                JMP pas_entree_food
            pas_repas:

            CMP menu_selection, 3
            JNE pas_retour_food
            
                MOV type_menu, 1 ;on change de menu
                MOV menu_selection, 1 ;on se met a la selection par defaut
                
                ;on efface;
                ;positionnement du curseur
                mov ah, 02h
                mov dl, 0
                mov dh, 23
                int 10h
                ;ecriture message
                MOV AH, 09h
                MOV DX, OFFSET effacer_interface
                INT 21h 
                
                CALL afficher_interface ;on rafraichi l'interface menu 
                
            pas_retour_food:
            
        pas_entree_food:
    
RET
food_menu ENDP


play_menu PROC
    
    ;; selection play menu ;;
    
    CMP ah, touche_gauche
        JNE pas_gauche_play
            dec menu_selection
            
            CMP menu_selection, 1
            JNL sup_1_play
                mov menu_selection, 3
            sup_1_play:
            
            CALL afficher_interface
            
        pas_gauche_play:
        
    CMP ah, touche_droite
        JNE pas_droite_play
            inc menu_selection
            
            CMP menu_selection, 3
            JNG inf_3_play
                mov menu_selection, 1
            inf_3_play:            
            
            CALL afficher_interface
        pas_droite_play: 
        
    
    ;; touche entree ;;
        
    CMP ah, touche_entree
        JNE pas_entree_play
            
            CMP menu_selection, 1
            JNE pas__gauche__play
                CALL action_gauche
                JMP pas_entree_play
            pas__gauche__play:
            
            CMP menu_selection, 2
            JNE pas__droite__play
                CALL action_droite 
                JMP pas_entree_play
            pas__droite__play:

            CMP menu_selection, 3
            JNE pas__retour__play
            
                MOV type_menu, 1 ;on change de menu
                MOV menu_selection, 2 ;on se met a l'encienne selection
                
                ;on efface;
                ;positionnement du curseur
                mov ah, 02h
                mov dl, 0
                mov dh, 23
                int 10h
                ;ecriture message
                MOV AH, 09h
                MOV DX, OFFSET effacer_interface
                INT 21h 
                
                CALL afficher_interface ;on rafraichi l'interface menu 
                
            pas__retour__play:
            
        pas_entree_play:
    
RET
play_menu ENDP


test_discipline PROC

                
        ;; gestion du random ;;
        
        ; =0   100% de chance de refuser
        ;100/1 100%
        ;100/2  50%
        ;100/3  33%
        ;100/4  25%
        ;100/5  20%
        ; >5    10% (100/10)
    
    ;on initialise timer_pause qui va servir au random
    mov cx, timer
    mov timer_pause, cx
    
    pusha
    
    mov dx, 0
    mov ax, timer_pause
    
    ;si la discipline est a 0    
    CMP discipline, 0    
    JNE discipline_non_0
        mov cx, 1 
    JMP fin_test_discipline
    discipline_non_0:
    
    ;si la discipline est >5
    CMP discipline, 5
    JNG discipline_non_sup_5
        mov cx, 10
    JMP fin_test_discipline 
    discipline_non_sup_5:    
    
    ;SINON    
        mov cx, discipline 
        
    
    ;Maintenant on test les chances
    fin_test_discipline:
    
        div cx  ;on effectue la division
            
        ;Si dx=0 SOIT reste nul SOIT timer_pause est un multiple de discipline
        CMP dx, 0
        JNE non_multiple
            mov refus, 1  ;il refuse
        JMP fin_multiple  
        non_multiple:
            mov refus, 0  ;il accepte
        fin_multiple:
        
    popa
        
        ;; FIN gestion du random ;;


RET
test_discipline ENDP

                                             


action_gauche PROC ;fonctionne si la division est impair

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    

;Si il accepte
CMP refus, 0
JNE refuse_jouer1

    ;division    
    mov ax, timer_pause
    shr ax, 1
    
    JNB pair_echec
        ;si c'est impair (ok)
          
            ;; on affiche le petit message + image ;;
        
        CALL effacer_bestiole    
        CALL bestiole_gauche
          
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 35
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET jouer_reussite
        INT 21h 
        
            ;; fin du petit message ;;
        
        ;on change les variables
        add bonheur, 1
        
        JMP fin_action_gauche
        
    pair_echec: ;si c'est pair (echec)
        
        CALL effacer_bestiole    
        CALL bestiole_droite
        
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 1
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET jouer_echec
        INT 21h
    fin_action_gauche:
    

    ;quoi qu'il arrive, ca augmente la faim
    add faim, 1 
    
    mov justification_reprimander, 0

    JMP fin_finale_action_gauche    
refuse_jouer1: ;Si il refuse

    ;; on affiche le petit message ;;
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 10
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET refus_jouer
    INT 21h     
    
        ;; fin petit message ;;
    
    CALL effacer_bestiole
    CALL bestiole_triste
                               
    mov justification_reprimander, 1
fin_finale_action_gauche:

CALL afficher_stats

;on efface;
;positionnement du curseur
mov ah, 02h
mov dl, 0
mov dh, 23
int 10h
;ecriture message
MOV AH, 09h
MOV DX, OFFSET effacer_interface
INT 21h
        
;on se remet au menu main
mov type_menu, 1
mov menu_selection, 2



CALL afficher_interface
CALL effacer_bestiole
CALL bestiole_face

RET
action_gauche ENDP

refus_jouer DB '"J',39,'ai pas envie de tourner la t',136,'te pour te faire plaisir"$'
                  
                  
action_droite PROC ;fonctionne si la division est pair

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h

;Si il accepte
CMP refus, 0
JNE refuse_jouer2

    ;division    
    mov ax, timer_pause
    shr ax, 1
    
    JNB impair_echec
        ;si c'est pair (ok)
          
            ;; on affiche le petit message ;;
            
        CALL effacer_bestiole    
        CALL bestiole_droite
          
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 35
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET jouer_reussite
        INT 21h 
        
            ;; fin du petit message ;;
        
        ;on change les variables
        add bonheur, 1
        
        JMP fin_action_droite
    
    impair_echec: ;si c'est impair (echec) 
    
            ;; on affiche le petit message ;;
            
        CALL effacer_bestiole    
        CALL bestiole_gauche
    
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 1
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET jouer_echec
        INT 21h                     
           
            ;; fin du petit message ;;
            
    fin_action_droite:

    ;quoi qu'il arrive, ca augmente la faim
    add faim, 1
    
    mov justification_reprimander, 0
    
    JMP fin_finale_action_droite    
refuse_jouer2: ;Si il refuse

    ;; on affiche le petit message ;;
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 10
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET refus_jouer
    INT 21h     
    
        ;; fin petit message ;;
    
    CALL effacer_bestiole
    CALL bestiole_triste
                               
    mov justification_reprimander, 1
fin_finale_action_droite:
    
    CALL afficher_stats

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h

;on se remet au menu main
mov type_menu, 1
mov menu_selection, 2


CALL afficher_interface
CALL effacer_bestiole
CALL bestiole_face
    
RET
action_droite ENDP

jouer_reussite DB 'Bien jou', 130,'$'
jouer_echec DB "Rat",130,", on dirait que tu es incapable de comprendre un simple animal domestique$"



action_gouter PROC


;Si il accepte
CMP refus, 0
JNE refuse1

    ;diminue la faim
    dec faim
    ;augmente le bonheur
    inc bonheur
     
      ;; on affiche le petit message ;; 
      
    CALL effacer_bestiole
    CALL bestiole_content
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 35
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET miam
    INT 21h     
    
        ;; fin petit message ;;
        
    mov justification_reprimander, 0 
    
    JMP fin_action_gouter    
refuse1: ;Si il refuse

    ;; on affiche le petit message ;;
    
    CALL effacer_bestiole
    CALL bestiole_triste
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 25
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET refus_gouter
    INT 21h     
    
        ;; fin petit message ;;
                               
    mov justification_reprimander, 1

fin_action_gouter:
    CALL afficher_stats

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h

;on se remet au menu main
mov type_menu, 1
mov menu_selection, 1

CALL afficher_interface
CALL effacer_bestiole
CALL bestiole_face

RET
action_gouter ENDP

miam DB '"miam !"$'
refus_gouter DB '"Je veux pas manger ta #!&%!"$'

action_repas PROC
    

;Si il accepte
CMP refus, 0
JNE refuse2

    ;diminue 2x la faim
    sub faim, 2
    
    
      ;; on affiche le petit message ;;
    CALL effacer_bestiole
    CALL bestiole_content
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 16
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET miam2
    INT 21h     
    
        ;; fin petit message ;; 
        
    mov justification_reprimander, 0

    JMP fin_action_repas    
refuse2: ;Si il refuse

    ;; on affiche le petit message ;;
    
    CALL effacer_bestiole
    CALL bestiole_triste
    
    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 20
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET refus_repas
    INT 21h     
    
        ;; fin petit message ;; 
        
    mov justification_reprimander, 1
    

fin_action_repas:

CALL afficher_stats

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h

;on se remet au menu main
mov type_menu, 1
mov menu_selection, 1

CALL afficher_interface
CALL effacer_bestiole
CALL bestiole_face

RET
action_repas ENDP

miam2 DB '"oh ! un vrai repas, enfin l',39,'espoir de survivre !$'
refus_repas DB '"M',136,'me un ',130,'thiopien refuserait de manger ',128,'a"$'                       
                       
                       
action_reprimander PROC
    
    CALL effacer_bestiole
    CALL bestiole_triste
               
    ;si c'est pas justifie 
CMP justification_reprimander, 0
JNE justifie 
    
    dec discipline
    sub bonheur, 3
    
          ;; on affiche le petit message ;;
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 16
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET reprimander1
    INT 21h     
    
        ;; fin petit message ;;
    
    JMP fin_action_justification  
    
    ;si c'est justifie
justifie:

    inc discipline
    sub bonheur, 1
    
          ;; on affiche le petit message ;;
    
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 5
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET reprimander2
    INT 21h     
    
        ;; fin petit message ;;


fin_action_justification: 

MOV justification_reprimander, 0 ;on remet la justification nulle car defoncer deux fois un animal, c'est pas cool

CALL afficher_stats

    ;on efface;
    ;positionnement du curseur
    mov ah, 02h
    mov dl, 0
    mov dh, 23
    int 10h
    ;ecriture message
    MOV AH, 09h
    MOV DX, OFFSET effacer_interface
    INT 21h
           
           
CALL afficher_interface
CALL effacer_bestiole
CALL bestiole_face
    
RET
action_reprimander ENDP

reprimander1 DB 'Est-ce si fun de mal-traiter un animal sans raison ?$'
reprimander2 DB "Il a bien merit",130," une correction. De toute facon il n'a pas de syndicat$"



afficher_interface PROC



;; MAIN MENU ;;      

CMP type_menu, 1
JNE type_menu_non_1
    CMP menu_selection, 1
    JNE non_main1
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_nourrir
        INT 21h
        
        JMP non_main3
    non_main1:
    
    CMP menu_selection, 2
    JNE non_mainA
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_jouer
        INT 21h
        
        JMP non_main3
    non_mainA:
    
    CMP menu_selection, 3
    JNE non_main3
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_reprimander
        INT 21h
    non_main3:
type_menu_non_1:
 
;; FOOD MENU ;;

CMP type_menu, 2
JNE type_menu_non_2
    CMP menu_selection, 1
    JNE non_food1
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_gouter
        INT 21h
        
        JMP non_food3
    non_food1:
    
    CMP menu_selection, 2
    JNE non_food2
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_repas
        INT 21h
        
        JMP non_food3
    non_food2:
    
    CMP menu_selection, 3
    JNE non_food3
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 23
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_retour
        INT 21h
        
        JMP non_food3
    non_food3:    
type_menu_non_2:

    
    ;; PLAY MENU ;;

CMP type_menu, 3
JNE type_menu_non_3
    CMP menu_selection, 1
    JNE non_play1
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 3
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_gauche_play
        INT 21h
        
        JMP non_play3
    non_play1:
    
    CMP menu_selection, 2
    JNE non_play2
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 3
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_droite_play
        INT 21h
        
        JMP non_play3
    non_play2:
    
    CMP menu_selection, 3
    JNE non_play3
        ;positionnement du curseur
        mov ah, 02h
        mov dl, 3
        mov dh, 23
        int 10h
        ;ecriture message
        MOV AH, 09h
        MOV DX, OFFSET interface_menu_retour_play
        INT 21h
        
        JMP non_play3
    non_play3:
 
type_menu_non_3:   
RET    
afficher_interface ENDP  

effacer_interface DB '                                                                               $'    
;effacer_interface DB 220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,220,223,36
interface_menu_nourrir DB ' [nourrir] |  jouer  |  reprimander  $'    
interface_menu_jouer DB '  nourrir  | [jouer] |  reprimander  $'    
interface_menu_reprimander DB '  nourrir  |  jouer  | [reprimander] $'        
interface_menu_gouter DB ' [gouter] |  repas  |  retour  $'
interface_menu_repas DB '  gouter  | [repas] |  retour  $'
interface_menu_retour DB '  gouter  |  repas  | [retour] $'
interface_menu_gauche_play DB ' Dans quel direction va-t-il regarder ? [gauche] |  droite  |  retour  $'
interface_menu_droite_play DB ' Dans quel direction va-t-il regarder ?  gauche  | [droite] |  retour  $'
interface_menu_retour_play DB ' Dans quel direction va-t-il regarder ?  gauche  |  droite  | [retour] $'    
    
afficher_stats PROC

;positionnement du curseur
mov ah, 02h
mov dl, 12
mov dh, 1
int 10h
;ecriture message
MOV AH, 09h
MOV DX, OFFSET interface_faim
INT 21h

;positionnement du curseur
mov ah, 02h
mov dl, 29
mov dh, 1
int 10h
;ecriture message
MOV AH, 09h
MOV DX, OFFSET interface_bonheur
INT 21h

;positionnement du curseur
mov ah, 02h
mov dl, 49
mov dh, 1
int 10h
;ecriture message
MOV AH, 09h
MOV DX, OFFSET interface_discipline
INT 21h

CALL afficher_barres_stats

RET
afficher_stats ENDP

interface_faim DB 'faim$'
interface_bonheur DB 'bonheur$'
interface_discipline DB 'discipline$'



afficher_barres_stats PROC

;on evite les depassements soit <0 ou >10
cmp faim,0 ;si <0
jnl suite1
    mov faim, 0    
suite1: cmp faim, 10 ;si >10
jng suite2
    ;mov faim, 10      ; ON LE FAIT CREVER !
    CALL effacer_bestiole
    CALL bestiole_morte
    jmp fin_of_the_dead
    
suite2:cmp bonheur,0 ;si <0
jnl suite3
    mov bonheur, 0    
suite3: cmp bonheur, 10 ;si >10
jng suite4
    mov bonheur, 10
    
suite4:cmp discipline,0 ;si <0
jnl suite5
    mov discipline, 0    
suite5: cmp discipline, 10 ;si >10
jng suite6
    mov discipline, 10
suite6:     

    
;positionnement du curseur
mov ah, 02h
mov dl, 17
mov dh, 1
int 10h

compteur DW ?
mov compteur, 0

mov cx, 10
jauge1:

    add compteur, 1
    
    mov bx, compteur
    
    CMP bx, faim
	JG pas_de_pixel1
	    ;puis on affiche
	    MOV AH, 09h
	    MOV DX, OFFSET pixel
	    INT 21h	
        JMP fin_jauge1
    
    pas_de_pixel1:
        MOV AH, 6h
        MOV DL, ' '
        INT 21h
           
    
	;mov ax, faim
	fin_jauge1:
LOOP jauge1


;positionnement du curseur
mov ah, 02h
mov dl, 37
mov dh, 1
int 10h

mov compteur, 0

mov cx, 10
jauge2:

    add compteur, 1
    
    mov bx, compteur
    
    CMP bx, bonheur
	JG pas_de_pixel2
	    ;puis on affiche
	    MOV AH, 09h
	    MOV DX, OFFSET pixel
	    INT 21h	
        JMP fin_jauge2
    
    pas_de_pixel2:
        MOV AH, 6h
        MOV DL, ' '
        INT 21h
           
    
	;mov ax, faim
	fin_jauge2:
LOOP jauge2



;positionnement du curseur
mov ah, 02h
mov dl, 60
mov dh, 1
int 10h

mov compteur, 0

mov cx, 10
jauge3:

    add compteur, 1
    
    mov bx, compteur
    
    CMP bx, discipline
	JG pas_de_pixel3
	    ;puis on affiche
	    MOV AH, 09h
	    MOV DX, OFFSET pixel
	    INT 21h	
        JMP fin_jauge3
    
    pas_de_pixel3:
        MOV AH, 6h
        MOV DL, ' '
        INT 21h
           
    
	;mov ax, faim
	fin_jauge3:
LOOP jauge3
    
ret
afficher_barres_stats ENDP

;no_pixel DB 8, 36       
pixel DB 178, 36 


afficher_cadre PROC

mov ah, 02h
mov dl, 0
mov dh, 3
int 10h
  
MOV AH, 09h
MOV DX, OFFSET cadre_haut
INT 21h

mov ah, 02h
mov dl, 0
mov dh, 21
int 10h
  
MOV AH, 09h
MOV DX, OFFSET cadre_bas
INT 21h

RET   
afficher_cadre ENDP

cadre_haut DB 223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,223,36
cadre_bas DB 220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,220,36

;il faut des dessins de 76*17 


include "affichage_bestiole.asm"     

fin_of_the_dead:


pusha
mov ah, 0h
int 16h
popa  

mov mort_now, 1

RET
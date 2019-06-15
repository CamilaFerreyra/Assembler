#ingreso lista, ordeno, muestro
.data 
largoL: word 13
Lista: word  13, 1, 3, 2, 5, 8, 0, 144, 34, 55, 89, 21, 1

MSJ1: .asciiz "Bienvenido! Vamos a ordenar la siguiente lista: "
ESP: .asciiz ", "
MSJ2: .asciiz "la lista ordenada es: "

.text
#void bubbleSort(int arr[], int n) 
#  int i, j; 
# for (i = 0; i < n-1; i++)        
#      // Last i elements are already in place    
#      for (j = 0; j < n-i-1; j++)  
#          if (arr[j] > arr[j+1]) 
#             swap(&arr[j], &arr[j+1]); 

la $a0, MSJ1
li $v0, 4
syscall





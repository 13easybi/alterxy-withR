# alterxy-withR
Change parameters of Alterxy workflow based in a list. <br>
Developed by: Daniel P. de Freitas impactr.info <br>

If you have an Alterxy workflow (with or withou in-db tools) and need to change in a lot of places a parameter or a lot of different parameters, this code can help you. With it you can change the Alterxy xml string based in a csv list and save a new Alterxy ".yxmd" for each new parameter.<br>
<br>
Just copy the "Execute_aqui.txt" and "Gera_arq_alterxy.R" to a folder that you want to create your new files. <br>
<br>
Change the extension of "Execute_aqui.txt" file to ".bat".<br><br>
<br>
Execute for the first time this batch "Execute_aqui.bat". The program will create all directories to work. <br>
<br>
In the new "parametro" folder, put your parameter file. For this we need to pay attention in two things:<br>
1 - you need a column name (Ex. parameters)<br>
2 - the first row after the column name is the value that you want to change in your Alterxy ".yxmd".<br> 
<br>
Put your the ".yxmd" Alterxy file in the root folder (same place of "Gera_arq_alterxy.R").<br>
<br>
Execute for the second time your "Execute_aqui.bat".<br>
<br>
If everything is correct your "resultados" folder should have one new ".yxmd" Alterxy file for each parameter of your list.

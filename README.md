# pokedex_mobile

Aplicación movil

Se implementó una pantalla de login, en ella se podrá iniciar sesión con un usuario registrado previamente o dar click en crear cuenta. 
[![Screenshot-20230822-220656.jpg](https://i.postimg.cc/jdX19T4G/Screenshot-20230822-220656.jpg)](https://postimg.cc/tYsDZLf5)

Para registrarse se tiene la siguiente pantalla, en ella se deberá ingresar un correo y contraseña. 
[![Screenshot-20230822-220819.jpg](https://i.postimg.cc/3rBRLyz7/Screenshot-20230822-220819.jpg)](https://postimg.cc/s1Msx2V0)

Si todo va correctamente, con ayuda de un SnackBar, se informa al usuario de que su cuenta a sido creada correctamente, ahora ya podrá inisiar sesión. 
[![Screenshot-20230822-220823.jpg](https://i.postimg.cc/tT91TF8S/Screenshot-20230822-220823.jpg)](https://postimg.cc/Y4y2DLrY)

Una vez inisiada sesión se le redirigirá a la pantalla de Perfil, esta es una pantalla simple que unicamente muestra el correo de la persona que esta registrada y adicinal un botón de cerrar sesion. 
[![Screenshot-20230822-220833.jpg](https://i.postimg.cc/VsrSNshc/Screenshot-20230822-220833.jpg)](https://postimg.cc/K4bcqbF9)

Adicional, se implementaron algunas funcionalidades adicionales:
* mientras se inisia sesión o se crea un usuario, el botón se desabilitará para evitar pulsasiones involuntarias por parte del usuario
* además el texto del botón cambia a una animacion de carga para que el usuario pueda ver como su solicitud está siendo procesada. 
* Al iniciar la aplicación, si anteriormente un usuario ya inició sesion entonces se le mostrará directamente la pantalla de Perfil de usuario, de lo contrario si aún no ha iniciado sesión la aplicación le mostrará la pantalla de login, verificando así si el usuario ya ha sido autenticado. 

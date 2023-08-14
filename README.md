# Challenge - Data security - Mercado Libre

## Levantar el proyecto
Para levantar el siguiente proyecto debe tener instalado en su maquina **Docker**, con un solo comando la aplicacion ya correra completamente, levantara la api, la base de datos de la app y la base de datos de prueba. Posteriormente cargara la base de datos de la aplicacion con las tablas pertinentes, al igual que en la base de datos de prueba.

Una vez clonado el repositorio, debera ejecutar el siguiente comando:

```
docker compose up
```

La API cuenta con los siguientes endpoints:

| Post | GET|
| --- | --- |
| /api/v1/database | /api/v1/database/scan/:id |
| /api/v1/database/scan/:id |

El primer enpoint **POST /api/v1/database/**, consiste en permitir la persistencia de datos de conexiones a otras bases de datos, que posteriormente podran ser escaneadas.

El segundo endpoint **POST /api/v1/database/:id** es para ejecutar la clasificacion de la de una base de datos, dicho **id** que se la pasa por paramentro corresponde a una conexion de una base de datos.

El tercer endpoint **GET /api/v1/database/:id** es para obtener la clasificacion de una base de datos, con sus tablas, columnas y el tipo de informacion identificada para cada columna.


## Diagrama de clases

![](./images/DDC_MELI.jpg)


## Tecnologias Utilizadas

- **Django rest framework**: es un marco de desarrollo para construir API en aplicaciones web utilizando el framework de Python llamado Django.

- **MySql**: Motor de base de datos relacional para dar persistencia de datos a los datos de la app.

- **Docker y docker compose**: Para crear la imagen de la Api desarrollada. Y docker compose para levantar y conectar los contedores de la aplicacion, la base de datos de la aplicacion y la base de datos de prueba, para que probar el funcionamiento del proyecto solicitado.

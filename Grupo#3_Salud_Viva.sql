#Crear la base de datos
create database salud_viva;
use salud_viva;

#Tabla de especialidades médicas
create table especialidades (
    id_especialidad int auto_increment primary key,
    nombre_especialidad varchar(100) not null unique,
    descripcion text
);

#Tabla de médicos
create table medicos (
    id_medico int auto_increment primary key,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    id_especialidad int not null,
    telefono varchar(15),
    email varchar(100) unique,
    foreign key (id_especialidad) references especialidades(id_especialidad)
);

#Tabla de pacientes
create table pacientes (
    id_paciente int auto_increment primary key,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    Identificacion varchar(15) not null,
    telefono varchar(15),
    correo varchar(100) unique,
    eps varchar(50) not null unique
);

#Tabla de citas
create table citas (
    id_cita int auto_increment primary key,
    id_paciente int not null,
    id_medico int not null,
    fecha_hora datetime not null,
    estado enum('programada', 'completada', 'cancelada') default 'programada',
    motivo text,
    fecha_creacion timestamp default current_timestamp,
    unique key unique_medico_hora (id_medico, fecha_hora),
    foreign key (id_paciente) references pacientes(id_paciente),
    foreign key (id_medico) references medicos(id_medico)
);

#Tabla de auditoría para cambios en citas
create table auditoria_citas (
    id_auditoria int auto_increment primary key,
    id_cita int not null,
    accion enum('creación', 'modificación', 'cancelación') not null,
    fecha_hora_anterior datetime,
    fecha_hora_nueva datetime,
    estado_anterior enum('programada', 'completada', 'cancelada'),
    estado_nuevo enum('programada', 'completada', 'cancelada'),
    usuario varchar(100) not null,
    fecha_cambio timestamp default current_timestamp,
    foreign key (id_cita) references citas(id_cita)
); 
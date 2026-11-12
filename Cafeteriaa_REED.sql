CREATE DATABASE IF NOT EXISTS reed_cafeteria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cafeteria_db;

-- 1. Tabla: categorias
CREATE TABLE IF NOT EXISTS categorias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 2. Tabla: productos
CREATE TABLE IF NOT EXISTS productos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2) NOT NULL,
    precio_costo DECIMAL(10, 2) DEFAULT 0.00,
    stock_actual INT DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    categoria_id BIGINT,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id)
) ENGINE=InnoDB;

-- 3. Tabla: roles
CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 4. Tabla: users
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    rol_id BIGINT,
    CONSTRAINT fk_user_rol FOREIGN KEY (rol_id) REFERENCES roles(id)
) ENGINE=InnoDB;

-- 5. Tabla: pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cliente_nombre VARCHAR(255) NOT NULL,
    cliente_telefono VARCHAR(50) NOT NULL,
    tipo_entrega VARCHAR(50) NOT NULL,
    direccion VARCHAR(255),
    metodo_pago VARCHAR(50) NOT NULL,
    notas TEXT,
    subtotal DECIMAL(10, 2) NOT NULL,
    costo_envio DECIMAL(10, 2) DEFAULT 0.00,
    total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    fecha DATETIME NOT NULL,
    fecha_entrega DATETIME,
    firma_recibido VARCHAR(255),
    usuario_id BIGINT,
    CONSTRAINT fk_pedido_usuario FOREIGN KEY (usuario_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- 6. Tabla: detalle_pedido
CREATE TABLE IF NOT EXISTS detalle_pedido (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    producto_nombre VARCHAR(255) NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    pedido_id BIGINT NOT NULL,
    producto_id BIGINT,
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
) ENGINE=InnoDB;

-- 7. Tabla: gastos
CREATE TABLE IF NOT EXISTS gastos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    concepto VARCHAR(255) NOT NULL,
    categoria_gasto VARCHAR(100) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha DATETIME NOT NULL,
    observaciones VARCHAR(255)
) ENGINE=InnoDB;

-- Mostrar las 7 tablas en pestañas de resultados
SHOW TABLES;
DESCRIBE categorias;
DESCRIBE productos;
DESCRIBE roles;
DESCRIBE users;
DESCRIBE pedidos;
DESCRIBE detalle_pedido;
DESCRIBE gastos;cafeteria_db
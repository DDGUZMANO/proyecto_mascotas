-- CreateTable
CREATE TABLE "Usuario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "surname" TEXT,
    "email" TEXT NOT NULL,
    "telefono" TEXT,
    "password" TEXT NOT NULL,
    "role" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "accepNotifications" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "bio" TEXT,
    "location" TEXT,
    "avatar" TEXT,
    "verified" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "Mascota" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nombre" TEXT NOT NULL,
    "raza" TEXT NOT NULL,
    "tamanio" TEXT NOT NULL,
    "edad" REAL NOT NULL,
    "tipo_alimentacion" TEXT NOT NULL,
    "necesidades_especiales" BOOLEAN NOT NULL,
    "ubicacion" TEXT NOT NULL,
    "dueñoId" INTEGER NOT NULL,
    CONSTRAINT "Mascota_dueñoId_fkey" FOREIGN KEY ("dueñoId") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Cuidador" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "usuarioId" INTEGER NOT NULL,
    "experiencia" INTEGER NOT NULL,
    "tarifas" REAL NOT NULL,
    "ubicacion" TEXT NOT NULL,
    "descripcion" TEXT,
    "tamanio_mascota_aceptada" TEXT NOT NULL,
    CONSTRAINT "Cuidador_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "TiposMascotasCuidador" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cuidadorId" INTEGER NOT NULL,
    "tipo" TEXT NOT NULL,
    CONSTRAINT "TiposMascotasCuidador_cuidadorId_fkey" FOREIGN KEY ("cuidadorId") REFERENCES "Cuidador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Valoracion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "usuarioId" INTEGER NOT NULL,
    "cuidadorId" INTEGER NOT NULL,
    "calificacion" INTEGER NOT NULL,
    "comentario" TEXT,
    CONSTRAINT "Valoracion_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "Usuario" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Valoracion_cuidadorId_fkey" FOREIGN KEY ("cuidadorId") REFERENCES "Cuidador" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

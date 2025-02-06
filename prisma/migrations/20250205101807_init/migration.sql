-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "ltree";

-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "uid" UUID NOT NULL DEFAULT gen_random_uuid(),
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT,
    "passwordHash" TEXT NOT NULL,
    "passwordSalt" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Todo" (
    "id" SERIAL NOT NULL,
    "uid" UUID NOT NULL DEFAULT gen_random_uuid(),
    "title" TEXT NOT NULL,
    "description" TEXT,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Todo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_uid_key" ON "User"("uid");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_username_idx" ON "User" USING GIN ("username" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User" USING GIN ("email" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "User_firstName_idx" ON "User" USING GIN ("firstName" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "User_lastName_idx" ON "User" USING GIN ("lastName" gin_trgm_ops);

-- CreateIndex
CREATE UNIQUE INDEX "Todo_uid_key" ON "Todo"("uid");

-- CreateIndex
CREATE INDEX "Todo_title_idx" ON "Todo" USING GIN ("title" gin_trgm_ops);

-- CreateIndex
CREATE INDEX "Todo_description_idx" ON "Todo" USING GIN ("description" gin_trgm_ops);

-- AddForeignKey
ALTER TABLE "Todo" ADD CONSTRAINT "Todo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

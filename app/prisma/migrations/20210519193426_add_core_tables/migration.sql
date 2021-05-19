/*
  Warnings:

  - The primary key for the `product_categories` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `product_images` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name` on the `product_images` table. All the data in the column will be lost.
  - You are about to drop the column `price` on the `product_images` table. All the data in the column will be lost.
  - You are about to drop the column `active` on the `product_images` table. All the data in the column will be lost.
  - The primary key for the `products` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `likes` on the `products` table. All the data in the column will be lost.
  - The primary key for the `roles` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the `_ProductToProductCategory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `product_orders` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `product_id` to the `product_categories` table without a default value. This is not possible if the table is not empty.
  - Added the required column `file_name` to the `product_images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `file_type` to the `product_images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mime_type` to the `product_images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `url` to the `product_images` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `likes_count` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `is_enable` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `stock_quantity` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `is_email_confirmed` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_ProductToProductCategory" DROP CONSTRAINT "_ProductToProductCategory_A_fkey";

-- DropForeignKey
ALTER TABLE "_ProductToProductCategory" DROP CONSTRAINT "_ProductToProductCategory_B_fkey";

-- DropForeignKey
ALTER TABLE "product_images" DROP CONSTRAINT "product_images_product_id_fkey";

-- AlterTable
ALTER TABLE "product_categories" DROP CONSTRAINT "product_categories_pkey",
ADD COLUMN     "product_id" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD PRIMARY KEY ("id");
DROP SEQUENCE "product_categories_id_seq";

-- AlterTable
ALTER TABLE "product_images" DROP CONSTRAINT "product_images_pkey",
DROP COLUMN "name",
DROP COLUMN "price",
DROP COLUMN "active",
ADD COLUMN     "file_name" TEXT NOT NULL,
ADD COLUMN     "file_type" TEXT NOT NULL,
ADD COLUMN     "mime_type" TEXT NOT NULL,
ADD COLUMN     "url" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "product_id" SET DATA TYPE TEXT,
ADD PRIMARY KEY ("id");
DROP SEQUENCE "product_images_id_seq";

-- AlterTable
ALTER TABLE "products" DROP CONSTRAINT "products_pkey",
DROP COLUMN "likes",
ADD COLUMN     "price" DECIMAL(12,2) NOT NULL,
ADD COLUMN     "likes_count" INTEGER NOT NULL,
ADD COLUMN     "is_enable" BOOLEAN NOT NULL,
ADD COLUMN     "stock_quantity" INTEGER NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(80),
ADD PRIMARY KEY ("id");
DROP SEQUENCE "products_id_seq";

-- AlterTable
ALTER TABLE "roles" DROP CONSTRAINT "roles_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD PRIMARY KEY ("id");
DROP SEQUENCE "roles_id_seq";

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "is_email_confirmed" BOOLEAN NOT NULL;

-- DropTable
DROP TABLE "_ProductToProductCategory";

-- DropTable
DROP TABLE "product_orders";

-- CreateTable
CREATE TABLE "user_address" (
    "id" TEXT NOT NULL,
    "address" VARCHAR(120) NOT NULL,
    "city" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "postalCode" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cart_items" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateDate" TIMESTAMP(3) NOT NULL,
    "product_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductLikes" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "createDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateDate" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_items" (
    "id" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unitPrice" DECIMAL(12,2) NOT NULL,
    "createDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateDate" TIMESTAMP(3) NOT NULL,
    "productId" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order" (
    "id" TEXT NOT NULL,
    "total" DECIMAL(12,2) NOT NULL,
    "taxes" DECIMAL(12,2) NOT NULL,
    "orderStatus" TEXT NOT NULL,
    "createDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateDate" TIMESTAMP(3) NOT NULL,
    "deliveryAddressId" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "user_address" ADD FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductLikes" ADD FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductLikes" ADD FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_items" ADD FOREIGN KEY ("orderId") REFERENCES "order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD FOREIGN KEY ("deliveryAddressId") REFERENCES "user_address"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_categories" ADD FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_images" ADD FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

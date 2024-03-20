/*
  Warnings:

  - The primary key for the `product` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `product` table. All the data in the column will be lost.
  - Added the required column `branding` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `evidence_product` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `evidence_tariff` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isActive` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `playbook` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `product_id` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `product_profile` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `taxonomy_id` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `unit_id` to the `product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `year` to the `product` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `product` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `branding` VARCHAR(191) NOT NULL,
    ADD COLUMN `category_id` INTEGER NOT NULL,
    ADD COLUMN `evidence_product` VARCHAR(191) NOT NULL,
    ADD COLUMN `evidence_tariff` VARCHAR(191) NOT NULL,
    ADD COLUMN `isActive` BOOLEAN NOT NULL,
    ADD COLUMN `playbook` VARCHAR(191) NOT NULL,
    ADD COLUMN `product_id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `product_profile` VARCHAR(191) NOT NULL,
    ADD COLUMN `progressEnum` ENUM('aquisition', 'activation', 'retention', 'referral', 'revenue') NOT NULL DEFAULT 'aquisition',
    ADD COLUMN `taxonomy_id` INTEGER NOT NULL,
    ADD COLUMN `unit_id` INTEGER NOT NULL,
    ADD COLUMN `year` INTEGER NOT NULL,
    MODIFY `name` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`product_id`);

-- CreateTable
CREATE TABLE `units` (
    `unit_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`unit_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `unit_id` INTEGER NOT NULL,
    `level_id` INTEGER NOT NULL,
    `login_credentials_id` VARCHAR(191) NOT NULL,
    `teams` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `users_login_credentials_id_key`(`login_credentials_id`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `login_credentials` (
    `login_credentials_id` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`login_credentials_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RefreshToken` (
    `id` VARCHAR(191) NOT NULL,
    `hashedToken` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `login_credentials_id` VARCHAR(191) NOT NULL,
    `revoked` BOOLEAN NOT NULL DEFAULT false,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `RefreshToken_id_key`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `unit_leader` (
    `leader_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `unit_id` INTEGER NOT NULL,

    UNIQUE INDEX `unit_leader_user_id_key`(`user_id`),
    UNIQUE INDEX `unit_leader_unit_id_key`(`unit_id`),
    PRIMARY KEY (`leader_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `levels` (
    `level_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`level_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `taxonomy` (
    `taxonomy_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `taxonomy_desc` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`taxonomy_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category` (
    `category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `category_desc` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`category_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `differentiation` (
    `dif_id` INTEGER NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(191) NOT NULL,
    `context` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`dif_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `dif_enabler_collection` (
    `dif_enabler_collection_id` INTEGER NOT NULL AUTO_INCREMENT,
    `point_description` VARCHAR(191) NOT NULL,
    `dif_id` INTEGER NOT NULL,

    PRIMARY KEY (`dif_enabler_collection_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `stpdb` (
    `stpdb_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_id` INTEGER NOT NULL,
    `dif_id` INTEGER NOT NULL,
    `branding` VARCHAR(191) NOT NULL,
    `positioning_description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`stpdb_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_services` (
    `ps_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ps_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_use_case` (
    `puc_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_id` INTEGER NOT NULL,
    `logo` VARCHAR(191) NOT NULL,
    `desc` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`puc_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operating_model` (
    `om_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_id` INTEGER NOT NULL,
    `partnership` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`om_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_businessflow` (
    `ombf_id` INTEGER NOT NULL AUTO_INCREMENT,
    `om_id` INTEGER NOT NULL,
    `operator` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ombf_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_supplier` (
    `oms_id` INTEGER NOT NULL AUTO_INCREMENT,
    `om_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`oms_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_location` (
    `oml_id` INTEGER NOT NULL AUTO_INCREMENT,
    `om_id` INTEGER NOT NULL,
    `location` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`oml_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_mgtsystems` (
    `omms_id` INTEGER NOT NULL AUTO_INCREMENT,
    `om_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`omms_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_information` (
    `omi_id` INTEGER NOT NULL AUTO_INCREMENT,
    `om_id` INTEGER NOT NULL,
    `scope` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`omi_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_busflownode` (
    `ombfn_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ombf_id` INTEGER NOT NULL,
    `desc` VARCHAR(191) NOT NULL,
    `position` INTEGER NOT NULL,

    PRIMARY KEY (`ombfn_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `om_infonode` (
    `omin_id` INTEGER NOT NULL AUTO_INCREMENT,
    `omi_id` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`omin_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `segment_targeting` (
    `st_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_id` INTEGER NOT NULL,
    `stpdb_id` INTEGER NOT NULL,
    `desc` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`st_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `st_positioning` (
    `st_pos` INTEGER NOT NULL AUTO_INCREMENT,
    `stpdb_id` INTEGER NOT NULL,
    `logo` VARCHAR(191) NOT NULL,
    `x` INTEGER NOT NULL,
    `y` INTEGER NOT NULL,

    PRIMARY KEY (`st_pos`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `st_futuregrowth` (
    `stfg_id` INTEGER NOT NULL AUTO_INCREMENT,
    `st_id` INTEGER NOT NULL,
    `user` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`stfg_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `st_targeting_user` (
    `sttu_id` INTEGER NOT NULL AUTO_INCREMENT,
    `st_id` INTEGER NOT NULL,
    `user` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`sttu_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_unit_id_fkey` FOREIGN KEY (`unit_id`) REFERENCES `units`(`unit_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_taxonomy_id_fkey` FOREIGN KEY (`taxonomy_id`) REFERENCES `taxonomy`(`taxonomy_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_unit_id_fkey` FOREIGN KEY (`unit_id`) REFERENCES `units`(`unit_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_level_id_fkey` FOREIGN KEY (`level_id`) REFERENCES `levels`(`level_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `users` ADD CONSTRAINT `users_login_credentials_id_fkey` FOREIGN KEY (`login_credentials_id`) REFERENCES `login_credentials`(`login_credentials_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RefreshToken` ADD CONSTRAINT `RefreshToken_login_credentials_id_fkey` FOREIGN KEY (`login_credentials_id`) REFERENCES `login_credentials`(`login_credentials_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `unit_leader` ADD CONSTRAINT `unit_leader_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `unit_leader` ADD CONSTRAINT `unit_leader_unit_id_fkey` FOREIGN KEY (`unit_id`) REFERENCES `units`(`unit_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `dif_enabler_collection` ADD CONSTRAINT `dif_enabler_collection_dif_id_fkey` FOREIGN KEY (`dif_id`) REFERENCES `differentiation`(`dif_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stpdb` ADD CONSTRAINT `stpdb_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `stpdb` ADD CONSTRAINT `stpdb_dif_id_fkey` FOREIGN KEY (`dif_id`) REFERENCES `differentiation`(`dif_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_services` ADD CONSTRAINT `product_services_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_use_case` ADD CONSTRAINT `product_use_case_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `operating_model` ADD CONSTRAINT `operating_model_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_businessflow` ADD CONSTRAINT `om_businessflow_om_id_fkey` FOREIGN KEY (`om_id`) REFERENCES `operating_model`(`om_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_supplier` ADD CONSTRAINT `om_supplier_om_id_fkey` FOREIGN KEY (`om_id`) REFERENCES `operating_model`(`om_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_location` ADD CONSTRAINT `om_location_om_id_fkey` FOREIGN KEY (`om_id`) REFERENCES `operating_model`(`om_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_mgtsystems` ADD CONSTRAINT `om_mgtsystems_om_id_fkey` FOREIGN KEY (`om_id`) REFERENCES `operating_model`(`om_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_information` ADD CONSTRAINT `om_information_om_id_fkey` FOREIGN KEY (`om_id`) REFERENCES `operating_model`(`om_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_busflownode` ADD CONSTRAINT `om_busflownode_ombf_id_fkey` FOREIGN KEY (`ombf_id`) REFERENCES `om_businessflow`(`ombf_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `om_infonode` ADD CONSTRAINT `om_infonode_omi_id_fkey` FOREIGN KEY (`omi_id`) REFERENCES `om_information`(`omi_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `segment_targeting` ADD CONSTRAINT `segment_targeting_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `segment_targeting` ADD CONSTRAINT `segment_targeting_stpdb_id_fkey` FOREIGN KEY (`stpdb_id`) REFERENCES `stpdb`(`stpdb_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `st_positioning` ADD CONSTRAINT `st_positioning_stpdb_id_fkey` FOREIGN KEY (`stpdb_id`) REFERENCES `stpdb`(`stpdb_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `st_futuregrowth` ADD CONSTRAINT `st_futuregrowth_st_id_fkey` FOREIGN KEY (`st_id`) REFERENCES `segment_targeting`(`st_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `st_targeting_user` ADD CONSTRAINT `st_targeting_user_st_id_fkey` FOREIGN KEY (`st_id`) REFERENCES `segment_targeting`(`st_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

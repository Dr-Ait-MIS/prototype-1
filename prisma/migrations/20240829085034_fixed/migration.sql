/*
  Warnings:

  - The primary key for the `Attendance` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Attendance` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `studentId` on the `Attendance` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `courseId` on the `Attendance` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `facultyId` on the `Attendance` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `Course` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `courseTypeId` on the `Course` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `Course` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `departmentId` on the `Course` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `Degree` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Degree` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `Department` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Department` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `Faculty` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Faculty` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `FacultyAchievement` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `FacultyAchievement` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `facultyId` on the `FacultyAchievement` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - The primary key for the `Student` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `usn` on the `Student` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `Student` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to drop the `CourseType` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[courseId]` on the table `Course` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[degreeId]` on the table `Degree` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[departmentId]` on the table `Department` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[StudentId]` on the table `Student` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `courseId` to the `Course` table without a default value. This is not possible if the table is not empty.
  - Added the required column `courseType` to the `Course` table without a default value. This is not possible if the table is not empty.
  - Added the required column `degreeId` to the `Degree` table without a default value. This is not possible if the table is not empty.
  - Added the required column `departmentId` to the `Department` table without a default value. This is not possible if the table is not empty.
  - Added the required column `StudentId` to the `Student` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Attendance` DROP FOREIGN KEY `Attendance_courseId_fkey`;

-- DropForeignKey
ALTER TABLE `Attendance` DROP FOREIGN KEY `Attendance_facultyId_fkey`;

-- DropForeignKey
ALTER TABLE `Attendance` DROP FOREIGN KEY `Attendance_studentId_fkey`;

-- DropForeignKey
ALTER TABLE `Course` DROP FOREIGN KEY `Course_courseTypeId_fkey`;

-- DropForeignKey
ALTER TABLE `Course` DROP FOREIGN KEY `Course_departmentId_fkey`;

-- DropForeignKey
ALTER TABLE `Department` DROP FOREIGN KEY `Department_degreeId_fkey`;

-- DropForeignKey
ALTER TABLE `Faculty` DROP FOREIGN KEY `Faculty_departmentId_fkey`;

-- DropForeignKey
ALTER TABLE `FacultyAchievement` DROP FOREIGN KEY `FacultyAchievement_facultyId_fkey`;

-- DropForeignKey
ALTER TABLE `Student` DROP FOREIGN KEY `Student_degreeId_fkey`;

-- DropForeignKey
ALTER TABLE `Student` DROP FOREIGN KEY `Student_departmentId_fkey`;

-- DropIndex
DROP INDEX `Student_usn_key` ON `Student`;

-- AlterTable
ALTER TABLE `Attendance` DROP PRIMARY KEY,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `studentId` INTEGER NOT NULL,
    MODIFY `courseId` INTEGER NOT NULL,
    MODIFY `facultyId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Course` DROP PRIMARY KEY,
    DROP COLUMN `courseTypeId`,
    ADD COLUMN `courseId` VARCHAR(191) NOT NULL,
    ADD COLUMN `courseType` VARCHAR(191) NOT NULL,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `departmentId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Degree` DROP PRIMARY KEY,
    ADD COLUMN `degreeId` VARCHAR(191) NOT NULL,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Department` DROP PRIMARY KEY,
    ADD COLUMN `departmentId` VARCHAR(191) NOT NULL,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Faculty` DROP PRIMARY KEY,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `FacultyAchievement` DROP PRIMARY KEY,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `facultyId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Student` DROP PRIMARY KEY,
    DROP COLUMN `usn`,
    ADD COLUMN `StudentId` VARCHAR(191) NOT NULL,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `CourseType`;

-- CreateIndex
CREATE UNIQUE INDEX `Course_courseId_key` ON `Course`(`courseId`);

-- CreateIndex
CREATE UNIQUE INDEX `Degree_degreeId_key` ON `Degree`(`degreeId`);

-- CreateIndex
CREATE UNIQUE INDEX `Department_departmentId_key` ON `Department`(`departmentId`);

-- CreateIndex
CREATE UNIQUE INDEX `Student_StudentId_key` ON `Student`(`StudentId`);

-- AddForeignKey
ALTER TABLE `Faculty` ADD CONSTRAINT `Faculty_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacultyAchievement` ADD CONSTRAINT `FacultyAchievement_facultyId_fkey` FOREIGN KEY (`facultyId`) REFERENCES `Faculty`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Student` ADD CONSTRAINT `Student_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`departmentId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Student` ADD CONSTRAINT `Student_degreeId_fkey` FOREIGN KEY (`degreeId`) REFERENCES `Degree`(`degreeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `Student`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_courseId_fkey` FOREIGN KEY (`courseId`) REFERENCES `Course`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_facultyId_fkey` FOREIGN KEY (`facultyId`) REFERENCES `Faculty`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Department` ADD CONSTRAINT `Department_degreeId_fkey` FOREIGN KEY (`degreeId`) REFERENCES `Degree`(`degreeId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Course` ADD CONSTRAINT `Course_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

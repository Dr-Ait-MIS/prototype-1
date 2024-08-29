/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `Post`;

-- DropTable
DROP TABLE `User`;

-- CreateTable
CREATE TABLE `Faculty` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `facultyId` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NOT NULL,
    `middleName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `joiningDate` DATETIME(3) NOT NULL,
    `designation` VARCHAR(191) NOT NULL,
    `departmentId` INTEGER NOT NULL,
    `phoneNumber` VARCHAR(191) NULL,
    `vtuId` VARCHAR(191) NULL,
    `aicteId` VARCHAR(191) NULL,
    `scopusId` VARCHAR(191) NULL,
    `orcidId` VARCHAR(191) NULL,
    `password` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Faculty_facultyId_key`(`facultyId`),
    UNIQUE INDEX `Faculty_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FacultyAchievement` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `facultyId` VARCHAR(191) NOT NULL,
    `achievement` VARCHAR(191) NOT NULL,
    `achievementUrl` VARCHAR(191) NULL,
    `awards` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Student` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(191) NOT NULL,
    `middleName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `joiningDate` DATETIME(3) NOT NULL,
    `branch` VARCHAR(191) NULL,
    `usn` VARCHAR(191) NOT NULL,
    `departmentId` INTEGER NOT NULL,
    `dob` DATETIME(3) NOT NULL,
    `semester` INTEGER NULL,
    `degreeId` INTEGER NOT NULL,
    `phoneNumber` VARCHAR(191) NULL,
    `sex` VARCHAR(191) NULL,
    `password` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Student_email_key`(`email`),
    UNIQUE INDEX `Student_usn_key`(`usn`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Attendance` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `studentId` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,
    `isPresent` BOOLEAN NOT NULL,
    `permission` BOOLEAN NULL,
    `notCounted` BOOLEAN NULL,
    `courseId` INTEGER NOT NULL,
    `facultyId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Degree` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Department` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `degreeId` INTEGER NOT NULL,
    `hod` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Course` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `credits` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `branchOffered` VARCHAR(191) NULL,
    `additionalCourses` VARCHAR(191) NULL,
    `courseCode` VARCHAR(191) NOT NULL,
    `departmentId` INTEGER NOT NULL,
    `courseTypeId` INTEGER NOT NULL,

    UNIQUE INDEX `Course_courseCode_key`(`courseCode`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CourseType` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `credits` INTEGER NOT NULL,
    `typeOfCourse` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Faculty` ADD CONSTRAINT `Faculty_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacultyAchievement` ADD CONSTRAINT `FacultyAchievement_facultyId_fkey` FOREIGN KEY (`facultyId`) REFERENCES `Faculty`(`facultyId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Student` ADD CONSTRAINT `Student_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Student` ADD CONSTRAINT `Student_degreeId_fkey` FOREIGN KEY (`degreeId`) REFERENCES `Degree`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `Student`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_courseId_fkey` FOREIGN KEY (`courseId`) REFERENCES `Course`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Attendance` ADD CONSTRAINT `Attendance_facultyId_fkey` FOREIGN KEY (`facultyId`) REFERENCES `Faculty`(`facultyId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Department` ADD CONSTRAINT `Department_degreeId_fkey` FOREIGN KEY (`degreeId`) REFERENCES `Degree`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Course` ADD CONSTRAINT `Course_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `Department`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Course` ADD CONSTRAINT `Course_courseTypeId_fkey` FOREIGN KEY (`courseTypeId`) REFERENCES `CourseType`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

import type { ColumnType } from "kysely";
export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;
export type Timestamp = ColumnType<Date, Date | string, Date | string>;

export type Attendance = {
    id: Generated<number>;
    studentId: number;
    date: Timestamp;
    isPresent: number;
    permission: number | null;
    notCounted: number | null;
    courseId: number;
    facultyId: number;
};
export type Course = {
    id: Generated<number>;
    credits: number;
    courseId: string;
    name: string;
    branchOffered: string | null;
    additionalCourses: string | null;
    courseCode: string;
    departmentId: number;
    courseType: string;
};
export type Degree = {
    id: Generated<number>;
    degreeId: string;
    name: string;
};
export type Department = {
    id: Generated<number>;
    departmentId: string;
    name: string;
    degreeId: string;
    hod: string | null;
};
export type Faculty = {
    id: Generated<number>;
    facultyId: string;
    firstName: string;
    middleName: string | null;
    lastName: string;
    email: string;
    address: string | null;
    joiningDate: Timestamp;
    designation: string;
    departmentId: string;
    phoneNumber: string | null;
    vtuId: string | null;
    aicteId: string | null;
    scopusId: string | null;
    orcidId: string | null;
    password: string;
};
export type FacultyAchievement = {
    id: Generated<number>;
    facultyId: number;
    achievement: string;
    achievementUrl: string | null;
    awards: string | null;
};
export type Student = {
    id: Generated<number>;
    firstName: string;
    middleName: string | null;
    lastName: string;
    email: string;
    address: string | null;
    joiningDate: Timestamp;
    branch: string | null;
    StudentId: string;
    departmentId: string;
    dob: Timestamp;
    semester: number | null;
    degreeId: string;
    phoneNumber: string | null;
    sex: string | null;
    password: string;
};
export type DB = {
    Attendance: Attendance;
    Course: Course;
    Degree: Degree;
    Department: Department;
    Faculty: Faculty;
    FacultyAchievement: FacultyAchievement;
    Student: Student;
};

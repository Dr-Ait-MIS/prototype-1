import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(){
    try {
        const students = await db.student.findMany();
        return NextResponse.json(students);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

// POST /api/students
export async function POST(req: Request) {
    try {
        const body = await req.json();
        const {
            firstName,
            middleName,
            lastName,
            email,
            address,
            joiningDate,
            branch,
            StudentId,
            departmentId,
            dob,
            semester,
            degreeId,
            phoneNumber,
            sex,
            password
        } = body;

        // Check if department exists
        const departmentExists = await db.department.findUnique({
            where: { departmentId }
        });

        if (!departmentExists) {
            return NextResponse.json({ message: "Department does not exist" }, { status: 404 });
        }

        // Check if degree exists
        const degreeExists = await db.degree.findUnique({
            where: { degreeId }
        });

        if (!degreeExists) {
            return NextResponse.json({ message: "Degree does not exist" }, { status: 404 });
        }

        // Check if the student already exists
        const studentExists = await db.student.findUnique({
            where: { StudentId }
        });

        if (studentExists) {
            return NextResponse.json({ message: "Student already exists" }, { status: 409 });
        }

        // Create a new student
        const newStudent = await db.student.create({
            data: {
                firstName,
                middleName,
                lastName,
                email,
                address,
                joiningDate,
                branch,
                StudentId,
                departmentId,
                dob,
                semester,
                degreeId,
                phoneNumber,
                sex,
                password
            }
        });

        return NextResponse.json(newStudent);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

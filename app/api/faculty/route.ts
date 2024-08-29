import db from "@/lib/db";
import { NextResponse } from "next/server";

// GET /api/faculty
export async function GET(req: Request) {
    try {
        const faculty = await db.faculty.findMany();
        return NextResponse.json(faculty);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

// POST /api/faculty
export async function POST(req: Request) {
    try {
        const body = await req.json();
        const {
            facultyId,
            firstName,
            middleName,
            lastName,
            email,
            address,
            joiningDate,
            designation,
            departmentId,
            phoneNumber,
            vtuId,
            aicteId,
            scopusId,
            orcidId,
            password
        } = body;

        // Check if the faculty already exists
        const facultyExists = await db.faculty.findUnique({
            where: { facultyId }
        });

        if (facultyExists) {
            return NextResponse.json({ message: "Faculty already exists" }, { status: 409 });
        }

        // Create a new faculty member
        const newFaculty = await db.faculty.create({
            data: {
                facultyId,
                firstName,
                middleName,
                lastName,
                email,
                address,
                joiningDate,
                designation,
                departmentId,
                phoneNumber,
                vtuId,
                aicteId,
                scopusId,
                orcidId,
                password
            }
        });

        return NextResponse.json(newFaculty);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}


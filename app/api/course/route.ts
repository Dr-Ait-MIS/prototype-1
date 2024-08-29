import db from "@/lib/db";
import { NextResponse } from "next/server";

// GET /api/courses
export async function GET() {
    try {
        const courses = await db.course.findMany();
        return NextResponse.json(courses);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

// POST /api/courses
export async function POST(req: Request) {
    try {
        const body = await req.json();
        const { courseId, name, credits, branchOffered, additionalCourses, courseCode, departmentId, courseType } = body;

        // Check if course already exists
        const courseExists = await db.course.findUnique({ where: { courseId } });
        if (courseExists) {
            return NextResponse.json({ message: "Course already exists" }, { status: 409 });
        }

        // Create new course
        const newCourse = await db.course.create({
            data: {
                courseId,
                name,
                credits,
                branchOffered,
                additionalCourses,
                courseCode,
                departmentId,
                courseType
            }
        });
        return NextResponse.json(newCourse);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

// PUT /api/courses/:id


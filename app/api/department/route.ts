import db from "@/lib/db";
import { NextResponse } from "next/server";


export async function GET(){
    try {
        const degrees = await db.department.findMany();
        return NextResponse.json(degrees);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}


export async function POST(req: Request) {
    try {
        const body = await req.json();
        const { departmentId, departmentName, degreeId, hod } = body;

        // Check if the degree exists
        const degreeExists = await db.degree.findUnique({
            where: { degreeId: degreeId }
        });

        if (!degreeExists) {
            return NextResponse.json({ message: "Degree not found" }, { status: 404 });
        }

        // Check if the department already exists
        const departmentExists = await db.department.findUnique({
            where: { departmentId: departmentId }
        });

        if (departmentExists) {
            return NextResponse.json({ message: "Department already exists" }, { status: 409 });
        }

        // Create the new department
        const newDepartment = await db.department.create({
            data: {
                departmentId,
                name: departmentName,
                degreeId,
                hod
            }
        });

        return NextResponse.json(newDepartment);
    } catch (error) {
        console.error(error);
        return NextResponse.error();
    }
}

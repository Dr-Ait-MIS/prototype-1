import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET() {
  try {
    // Using db to fetch degrees
    const degrees = await db
      .selectFrom('Degree')
      .selectAll()
      .execute();
      
    return NextResponse.json(degrees);
  } catch (error) {
    console.error('Error fetching degrees:', error);
    return NextResponse.json({ error: 'Error fetching degrees' }, { status: 500 });
  }
}

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const { degreeId, degreeName } = body;

    // Using Kysely to check if degree exists
    const existingDegrees = await db
      .selectFrom('Degree')
      .selectAll()
      .where('degreeId', '=', degreeId)
      .execute();

    if (existingDegrees.length > 0) {
      return NextResponse.json({ message: "Degree already exists" }, { status: 409 });
    }

    // Using Kysely to create a new degree
    await db
      .insertInto('Degree')
      .values({
        degreeId,
        name: degreeName,
      })
      .execute();

    // Retrieve the newly inserted degree
    const newDegree = await db
      .selectFrom('Degree')
      .selectAll()
      .where('degreeId', '=', degreeId)
      .executeTakeFirstOrThrow();

    return NextResponse.json(newDegree);
  } catch (error) {
    console.error('Error creating degree:', error);
    return NextResponse.json({ error: 'Error creating degree' }, { status: 500 });
  }
}

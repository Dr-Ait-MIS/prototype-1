import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { NextAuthOptions} from "next-auth";
import CredentialsProvider from 'next-auth/providers/credentials';
import db from '../lib/db';
import bcrypt from 'bcrypt';
import { User } from '@prisma/client';

export const authOptions: NextAuthOptions = {
    adapter: PrismaAdapter(db),
    secret: process.env.NEXTAUTH_SECRET,
    session: {
        strategy: 'jwt',
    },
    pages: {
        signIn: '/login',
    },
    providers: [
        CredentialsProvider({
            name: 'Faculty Login',
            id: 'faculty-login',
            credentials: {
                username: { label: "Email", type: "text", placeholder: "Enter a Valid email" },
                password: { label: "Password", type: "password" }
            },
            async authorize(credentials, req): Promise<User | null> {
                if (!credentials?.username || !credentials?.password) {
                    console.log("Missing credentials");
                    return null;
                }

                // Find faculty by email
                const faculty = await db.faculty.findUnique({
                    where: {
                        email: credentials.username
                    }
                });

                if (!faculty) {
                    console.log("Faculty not found");
                    return null;
                }

                // Validate password
                const isValid = await bcrypt.compare(credentials.password, faculty.password);
                if (!isValid) {
                    console.log("Invalid password");
                    return null;
                }

                console.log("Faculty authenticated successfully");
                return {
                    ...faculty,
                    id: faculty.id,
                    name: `${faculty.firstName} ${faculty.lastName}`,
                    email: faculty.email,
                };
            }
        }),

        // Credentials Provider for Student
        CredentialsProvider({
            name: 'Student Login',
            id: 'student-login',
            credentials: {
                username: { label: "Email", type: "text", placeholder: "Enter a Valid email" },
                password: { label: "Password", type: "password" }
            },
            async authorize(credentials, req): Promise<User | null> {
                if (!credentials?.username || !credentials?.password) {
                    console.log("Missing credentials");
                    return null;
                }

                // Find student by email
                const student = await db.student.findUnique({
                    where: {
                        email: credentials.username
                    }
                });

                if (!student) {
                    console.log("Student not found");
                    return null;
                }

                // Validate password
                const isValid = await bcrypt.compare(credentials.password, student.password);
                if (!isValid) {
                    console.log("Invalid password");
                    return null;
                }

                console.log("Student authenticated successfully");
                return {
                    ...student,
                    id: student.id,
                    name: `${student.firstName} ${student.lastName}`,
                    email: student.email,
                };
            }
        })
    ],
    callbacks: {
        async jwt({ token, user }) {
            if (user) {
                token.id = user.id;
                token.role = user instanceof db.Faculty ? 'faculty' : 'student';  // Add role
            }
            return token;
        },
        async session({ session, token }) {
            if (token && session.user) {
                session.user.id = token.id;
                session.user.role = token.role;  // Include role in session
            }
            return session;
        }
    }
};

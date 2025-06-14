import { prisma } from "~/lib/db";

export default defineEventHandler(async (event) => {
  try {
    const users = await prisma.user.findMany(); // Adjust based on your schema
    return { success: true, data: users };
  } catch (error) {
    return { success: false, error: error.message };
  }
});
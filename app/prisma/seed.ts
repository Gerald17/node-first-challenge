import users from '../mock/users';
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient()

async function main() {

    // creates users with roles
    for(let user of users) {
        const { id, firstName, lastName, email, password, role, isEmailConfirmed } = user;
        const userRole = {
            id,
            firstName,
            lastName,
            email,
            password,
            isEmailConfirmed,
            roles: {
                create: [{ role }]
            }
        }
        await prisma.user.create({
            data: userRole
        });
    }
}

main()
  .catch(e => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
import { PrismaClient, Usuario } from "@prisma/client"  //para interactuar con la base de datos
import jwt from "jsonwebtoken"  // para generar tokens de autenticación
import bcrypt from "bcrypt"// para encriptar contraseñas

///CONTIENE LA LOGICA DE NEGOCIO


const prisma =new PrismaClient()


const TOKEN_PASSWORD = process.env.TOKEN_PASSWORD || 'pass'

export class AuthService{
    static async register(usuario:Usuario){

         // ver si el usuario no existe
         // SELECT id,nombre FROM usuario WHERE email=usuario.email
        const findusuario =await prisma.usuario.findUnique({where:{email:usuario.email}})
        if(findusuario) throw new Error(`usuario ${usuario.email} already exist`)
        
        //ecryptar el password
        const passwordEncrypted = await bcrypt.hash(usuario.password, 10)
usuario.password = ''

   // guardar el usuario en la bd
         // INSERT INTO usuario (name, password, email) VALUES (?,?,?)

         return await prisma.usuario.create({
            data:{
                ...usuario,
                password: passwordEncrypted,
                role:null
            },
            omit:{
                password:true
            }
         })
        
        }

        static async login (email:string, password:string){

            //ver si el usuario existe
            const findusuario =await prisma.usuario.findUnique({where:{email}})
            if(!findusuario)throw new Error('Invalid usuario or password')

                //gerenar el token de autenticacion
                const token =jwt.sign(
                    {colorfavorito:'azul', id:findusuario.id, email: findusuario.email, role:findusuario.role},
                    TOKEN_PASSWORD,
                    {expiresIn:"1h"}

                )
                //devolver el token
                return token
                
        }


}
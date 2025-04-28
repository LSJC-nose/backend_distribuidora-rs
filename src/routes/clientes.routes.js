import { Router } from 'express';
import {  obtenerClientes,
   obtenerCliente,
    registrarCliente,
    eliminarCliente, 
    actualizarCliente
  } from '../controllers/clientes.controller.js';

const router = Router();

// Ruta para obtener todos los clientes
router.get('/cliente', obtenerClientes);

// Ruta para obtener un cliente por su ID
router.get('/cliente/:id', obtenerCliente);

// Ruta para registrar todos los clientes
router.post('/registrarcliente', registrarCliente);

router.delete('/eliminarclientes/:id', eliminarCliente);

router.patch('/actualizarcliente/:id', actualizarCliente);

export default router;
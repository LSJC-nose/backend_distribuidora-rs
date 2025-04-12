import { Router } from 'express';
import {  obtenerTipoCliente } from '../controllers/tipoCliente.controller.js';

const router = Router();

// Ruta para obtener todas las categorias
router.get('/tipocliente', obtenerTipoCliente);

export default router;
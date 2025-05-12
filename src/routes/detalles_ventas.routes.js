import { Router } from 'express';
import {  obtenerDetalle } from '../controllers/detalles_ventas.controller.js';

const router = Router();

// Ruta para obtener los detalles de una venta
router.get('/obtenerdetallesventa/:id_venta', obtenerDetalle);


export default router;
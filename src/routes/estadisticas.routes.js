import { Router } from 'express';
import { comprasPorCliente, resumenVentasDiarias } from '../controllers/estadisticas.controller.js';

const router = Router();

// Ruta para obtener todas las ventas diarias
router.get('/resumenVentasDiarias', resumenVentasDiarias); // Cambiado a minúsculas para consistencia
// Ruta para obtener las compras por cliente
router.get('/comprasPorCliente', comprasPorCliente); // Cambiado a minúsculas para consistencia
export default router;
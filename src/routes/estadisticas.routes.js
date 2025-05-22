import { Router } from 'express';
import {  resumenDeVentasDiarias } from '../controllers/estadisticas.controller.js';

const router = Router();

// Ruta para obtener todas las ventas
router.get('/resumenVentasDiarias', resumenDeVentasDiarias);
// Ruta para obtener todas las ventas por mes

export default router;
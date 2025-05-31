    import { Router } from 'express';
    import {  obtenerDetallesCompra, } from '../controllers/detallecompra.js';

    const router = Router();

// Ruta para obtener una compra por su ID
router.get('/obtenerdetallescompras/:ID_CompraFactura', obtenerDetallesCompra);

export default router;
    import { Router } from 'express';
    import {  obtenerCompraPorId, obtenerCompras, eliminarCompras, registrarCompras, actualizarCompras} from '../controllers/comprafactura.controller.js';

    const router = Router();

// Ruta para obtener una compra por su ID
router.get('/obtenercompraporid/:ID_CompraFactura', obtenerCompraPorId);

// Ruta para obtener todas las compras
router.get('/obtenercompras', obtenerCompras);

// Ruta para eliminar una compra
router.delete('/eliminarcompra/:ID', eliminarCompras);

// Ruta para registrar una nueva compra
router.post('/registrarcompras', registrarCompras);

// Ruta para actualizar una compra
router.patch('/actualizarcompra/:ID_CompraFactura', actualizarCompras);


    export default router;
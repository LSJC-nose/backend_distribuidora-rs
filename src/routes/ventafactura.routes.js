import { Router } from 'express';
import { obtenerVentasConDetalles, 
  obtenerVentas, 
  eliminarVenta,
   registrarVenta, 
   actualizarVenta, 
   obtenerVentaPorId } from '../controllers/venta.controller.js';

const router = Router();

// Ruta para obtener todos los usuarios.
router.get('/venta', obtenerVentasConDetalles);

router.get('/obtenerventas', obtenerVentas);

router.get('/obtenerventaporid/:NumeroFactura', obtenerVentaPorId);

router.delete('/eliminarventa/:NumeroFactura', eliminarVenta);

router.post('/registrarventas', registrarVenta);

// Ruta para actualizar una venta
router.patch('/actualizarventa/:NumeroFactura', actualizarVenta);


export default router;
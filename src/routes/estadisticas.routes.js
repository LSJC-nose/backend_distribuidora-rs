import { Router } from 'express';
import { comprasPorCliente, resumenVentasDiarias, ProductosBajoStock, obtenerVentas, obtenerClientes, obtenerProductos } from '../controllers/estadisticas.controller.js';

const router = Router();

// Ruta para obtener todas las ventas diarias
router.get('/resumenVentasDiarias', resumenVentasDiarias); // Cambiado a minúsculas para consistencia
// Ruta para obtener las compras por cliente
router.get('/comprasPorCliente', comprasPorCliente); // Cambiado a minúsculas para consistencia
// Ruta para obtener las compras por cliente
router.get('/comprasPorCliente', comprasPorCliente); // Cambiado a minúsculas para consistencia
router.get('/productosBajoStock', ProductosBajoStock);
router.get('/obtenerventas', obtenerVentas);
router.get('/clientes', obtenerClientes);
router.get('/productos', obtenerProductos); // Nueva ruta

export default router;
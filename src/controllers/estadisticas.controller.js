// src/controllers/estadisticas.controller.js
import { pool2 } from '../db.js';

export const resumenVentasDiarias = async (req, res) => {
  try {
    const [result] = await pool2.query(
      `SELECT DATE_FORMAT(t.fecha_venta, '%Y-%m-%d') AS dia, ROUND(SUM(hv.total_venta), 2) AS total_ventas
       FROM hecho_venta hv
       JOIN Dim_Tiempo t ON hv.fecha_venta = t.fecha_venta
       GROUP BY t.fecha_venta
       ORDER BY t.fecha_venta;`
    );
    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron estadísticas de ventas.',
      });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener las estadísticas de ventas.',
      error: error.message,
    });
  }
};

export const comprasPorCliente = async (req, res) => {
  try {
    const [result] = await pool2.query(
      `SELECT 
    c.Nombre,
    c.Apellido,
    COUNT(vf.NumeroFactura) AS compras
    FROM dim_cliente c
    INNER JOIN hecho_venta vf ON c.ID_Cliente = vf.ID_Cliente
    GROUP BY c.ID_Cliente;`
    );
    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron datos de compras por cliente.',
      });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener las compras por cliente.',
      error: error.message,
    });
  }
};

export const ProductosBajoStock = async (req, res) => {
  try {
    const [result] = await pool2.query(
      `SELECT 
         nombreProducto, 
         Stock
       FROM dim_producto  
       WHERE Stock < 10;`
    );
    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron productos con bajo stock.',
      });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los productos con bajo stock.',
      error: error.message,
    });
  }
};

export const obtenerProductos = async (req, res) => {
  try {
    const [result] = await pool2.query(`SELECT * FROM producto`);
    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron productos.',
      });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los productos.',
      error: error.message,
    });
  }
};

// Obtener todos los clientes
export const obtenerClientes= async (req, res) => {
  try {
    const [result] = await pool2.query(`
    SELECT 
    a.ID_Cliente,
    a.Nombre, 
    a.Apellido, 
    c.TipoCliente
 FROM 
    tipoCliente c 
 INNER JOIN 
    Cliente a ON c.ID_tipoCliente = a.ID_tipoCliente`);

    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de los clientes.',
      error: error
    });
  }
};

// Obtener todas las ventas
export const obtenerVentas = async (req, res) => {
  try {
    const [result] = await pool2.query(`
      SELECT 
        vf.NumeroFactura AS id_venta,
        vf.fecha_venta,
        CONCAT(c.Nombre, ' ', c.Apellido) AS nombre_cliente,
        SUM(dv.Cantidad * dv.PrecioVenta) AS subtotal
      FROM Venta_factura vf
      INNER JOIN Cliente c ON vf.ID_Cliente = c.ID_Cliente
      INNER JOIN Detalle_venta_factura dv ON vf.NumeroFactura = dv.NumeroFactura
      GROUP BY vf.NumeroFactura
    `);
    
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las ventas.',
      error: error.message
    });
  }
};

// src/controllers/estadisticas.controller.js
import { pool } from '../db.js';

export const resumenVentasDiarias = async (req, res) => {
  try {
    const [result] = await pool.query(
      `SELECT DATE(v.fecha_venta) AS dia, SUM(dvf.precio_venta * dvf.Cantidad) AS total_ventas 
       FROM Venta_factura v 
       JOIN Detalle_venta_factura dvf ON v.numero_factura = dvf.numero_factura 
       GROUP BY DATE(v.fecha_venta) 
       ORDER BY dia;`
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
    const [result] = await pool.query(
      `SELECT 
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_cliente,
    COUNT(vf.numero_factura) AS cantidad_compras
    FROM cliente c
    LEFT JOIN venta_factura vf ON c.id_cliente = vf.id_cliente
    GROUP BY c.id_cliente, c.nombre, c.apellido
    ORDER BY cantidad_compras DESC;`
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
// src/controllers/estadisticas.controller.js
import { pool } from '../db.js';

export const resumenVentasDiarias = async (req, res) => {
  try {
    const [result] = await pool.query(
      `SELECT DATE(v.fecha_venta) AS dia, SUM(dvf.precio_venta * dvf.Cantidad) AS total_ventas
      FROM Venta_factura v 
      JOIN Detalle_venta_factura dvf ON v.numero_factura = dvf.numero_factura 
      GROUP BY DATE(v.fecha_venta);`
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
    c.nombre,
    c.apellido,
    COUNT(vf.numero_factura) AS compras
    FROM cliente c
    INNER JOIN venta_factura vf ON c.id_cliente = vf.id_cliente
    GROUP BY c.id_cliente;`
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
    const [result] = await pool.query(
      `SELECT 
         id_producto AS ID_Producto, 
         nombre_producto AS nombreProducto, 
         stock AS Stock, 
         precio_compra AS PrecioCompra, 
         precio_venta AS PrecioVenta, 
         descripcion AS Descripcion, 
         ubicacion_fotografia AS UbicacionFotografia 
       FROM producto 
       WHERE stock < 10;`
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
    const [result] = await pool.query(`SELECT * FROM producto`);
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
    const [result] = await pool.query(`
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
    const [result] = await pool.query(`
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

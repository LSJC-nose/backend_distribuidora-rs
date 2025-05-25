import { pool2 } from '../db.js';

// Obtener el Total de ventas por día
export const resumenDeVentasDiarias = async (req, res) => {
  try {
    const [result] = await pool2.query(
      ` SELECT DATE(v.fecha_venta) AS dia, SUM(dvf.PrecioVenta * dvf.Cantidad)
       AS total_ventas FROM Venta_factura v JOIN Detalle_venta_factura dvf ON v.NumeroFactura = dvf.NumeroFactura 
       GROUP BY DATE(v.fecha_venta) ORDER BY dia; `
    );
    if (result.length === 0) {
      return res.status(404).json({
        mensaje: 'No se encontraron estadisticas de ventas.',
      });
    }
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener  las estadisticas de ventas.',
      error: error.message,
    });
  }
};
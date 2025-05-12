import { pool } from '../db.js';

// Obtener todas las ventas con sus detalles, mostrando nombres, IDs y subtotal
export const obtenerVentasConDetalles = async (req, res) => {
  try {
    const [result] = await pool.query(`
      SELECT 
        vf.NumeroFactura AS id_venta,
        dv.ID_Detalle AS id_detalle_venta,
        vf.fecha_venta ,
        CONCAT(c.Nombre, ' ', c.Apellido) AS nombre_cliente,
        p.nombreProducto,
        dv.Cantidad,
        dv.PrecioVenta AS precio_unitario,
        (dv.Cantidad * dv.PrecioVenta) AS subtotal
      FROM Venta_factura vf
      INNER JOIN Cliente c ON vf.ID_Cliente = c.ID_Cliente
      INNER JOIN Detalle_venta_factura dv ON vf.NumeroFactura = dv.NumeroFactura
      INNER JOIN Producto p ON dv.ID_Producto = p.ID_Producto
    `);
    
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las ventas.',
      error: error.message
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

// Eliminar una venta (los detalles se eliminan automáticamente por ON DELETE CASCADE)
export const eliminarVenta = async (req, res) => {
  try {
    const { NumeroFactura } = req.params;

    const [result] = await pool.query('DELETE FROM venta_factura WHERE NumeroFactura = ?', [NumeroFactura]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Venta no encontrada' });
    }

    res.json({ mensaje: 'Venta y sus detalles eliminados correctamente' });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Error al eliminar la venta',
      error: error.message
    });
  }
};  

// Obtener una venta específica por id_venta
export const obtenerVentaPorId = async (req, res) => {
  try {
    const { id_venta } = req.params;

    const [venta] = await pool.query(`
      SELECT 
        NumeroFactura,
        ID_Cliente,
        fecha_venta,
        total_venta
      FROM venta_factura
      WHERE NumeroFactura = ?
    `, [id_venta]);

    if (venta.length === 0) {
      return res.status(404).json({ mensaje: 'Venta no encontrada' });
    }

    res.json(venta[0]); // Devuelve solo el primer objeto (una sola venta)
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los datos de la venta.',
      error: error.message
    });
  }
};

// Registrar una nueva venta con detalles
export const registrarVenta = async (req, res) => {
  const { id_cliente, fecha_venta,total_venta, detalles } = req.body;

  try {
    const fechaVentaFormateada = new Date(fecha_venta).toISOString().slice(0, 19).replace('T', ' '); // Convierte a 'YYYY-MM-DD HH:mm:ss'
    const [ventaResult] = await pool.query(
      'INSERT INTO Venta_factura (ID_Cliente, fecha_venta,total_venta ) VALUES (?, ?, ?)',
      [id_cliente, fechaVentaFormateada, ]
    );

    const numero_factura = ventaResult.insertId;

    for (const detalle of detalles) {
      await pool.query(
        'INSERT INTO Detalle_venta_factura (ID_Producto, Cantidad, NumeroFactura, PrecioVenta) VALUES (?, ?, ?, ?)',
        [detalle.ID_Producto, detalle.Cantidad, numero_factura, detalle.PrecioVenta]
      );
      await pool.query(
        'UPDATE Producto SET Stock = Stock - ? WHERE ID_Producto = ?',
        [detalle.Cantidad, detalle.ID_Producto]
      );
    }

    res.json({ mensaje: 'Venta registrada correctamente' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al registrar la venta', error: error.message });
  }
};

// Actualizar una venta con sus detalles
export const actualizarVenta = async (req, res) => {
  const { numero_factura } = req.params;
  const { id_cliente, fecha_venta, detalles } = req.body;

  try {
    // Formatear la fecha al formato MySQL
    const fechaVentaFormateada = new Date(fecha_venta).toISOString().slice(0, 19).replace('T', ' ');

    // Actualizar la venta
    const [ventaResult] = await pool.query(
      'UPDATE Venta_factura SET ID_Cliente = ?, fecha_venta = ? WHERE NumeroFactura = ?',
      [id_cliente, fechaVentaFormateada, numero_factura]
    );

    if (ventaResult.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Venta no encontrada' });
    }

    // Obtener detalles actuales para restaurar stock
    const [detallesActuales] = await pool.query(
      'SELECT ID_Producto, Cantidad FROM Detalle_venta_factura WHERE NumeroFactura = ?',
      [numero_factura]
    );

    // Restaurar stock de productos anteriores
    for (const detalle of detallesActuales) {
      await pool.query(
        'UPDATE Producto SET Stock = Stock + ? WHERE ID_Producto = ?',
        [detalle.Cantidad, detalle.ID_Producto]
      );
    }

    // Eliminar detalles actuales
    await pool.query('DELETE FROM Detalle_venta_factura WHERE NumeroFactura = ?', [numero_factura]);

    // Insertar nuevos detalles y actualizar stock
    for (const detalle of detalles) {
      await pool.query(
        'INSERT INTO Detalle_venta_factura (ID_Producto, Cantidad, NumeroFactura, PrecioVenta) VALUES (?, ?, ?, ?)',
        [detalle.id_producto, detalle.cantidad, numero_factura, detalle.precio_venta]
      );
      await pool.query(
        'UPDATE Producto SET Stock = Stock - ? WHERE ID_Producto = ?',
        [detalle.cantidad, detalle.id_producto]
      );
    }

    res.json({ mensaje: 'Venta actualizada correctamente' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al actualizar la venta', error: error.message });
  }
};

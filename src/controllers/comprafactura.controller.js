import { pool } from '../db.js';




// Obtener una compra específica por id_compra
export const obtenerCompraPorId = async (req, res) => {
  try {
    const { ID_CompraFactura } = req.params;

    const [compra] = await pool.query(`
      SELECT 
        ID_CompraFactura,
        ID_Proveedores,
        fecha_compra,
        total_compra
      FROM Compra_factura
      WHERE ID_CompraFactura = ?
    `, [ID_CompraFactura]);

    if (compra.length === 0) {
      return res.status(404).json({ mensaje: 'Compra no encontrada' });
    }

    res.json(compra[0]);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al obtener los datos de la compra.',
      error: error.message
    });
  }
};

// Obtener todas las compras
export const obtenerCompras = async (req, res) => {
  try {
    const [result] = await pool.query(`
      SELECT 
        c.ID_CompraFactura,
        DATE_FORMAT(c.fecha_compra, '%d/%m/%Y') AS fecha_compra,
        e.NombreProveedor,
        c.total_compra
      FROM Compra_factura c
      INNER JOIN Proveedores e ON c.ID_Proveedores = e.ID_Proveedores
    `);
    
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las compras.',
      error: error
    });
  }
};

// Eliminar una compra (los detalles se eliminan automáticamente por ON DELETE CASCADE)
export const eliminarCompras = async (req, res) => {
  try {
    const { ID } = req.params;

    const [result] = await pool.query('DELETE FROM Compra_factura WHERE ID_CompraFactura = ?', [ID]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Compra no encontrada' });
    }

    res.json({ mensaje: 'Compra y sus detalles eliminados correctamente' });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Error al eliminar la compra',
      error: error.message
    });
  }
};


export const registrarCompras = async (req, res) => {
  const { ID_Proveedores, fecha_compra, total_compra, detalles } = req.body;

  try {
    // Calcular nombre_mes y dia_semana
    //const fecha = new Date(fecha_compra);
    //const meses = [
     // 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
     // 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    //];
    //const diasSemana = [
    //  'Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'
    //];
    
    //const nombreMes = meses[fecha.getMonth()];
    //const diaSemana = diasSemana[fecha.getDay()];

    // Insertar en Compra_factura incluyendo nombre_mes y dia_semana
    const [compraResult] = await pool.query(
      'INSERT INTO Compra_factura (ID_Proveedores, fecha_compra, total_compra) VALUES (?, ?, ?)',
      [ID_Proveedores, fecha_compra, total_compra]// nombreMes, diaSemana]
    );

    const ID_CompraFactura = compraResult.insertId;

    // Insertar detalles y actualizar stock
    for (const detalle of detalles) {
      await pool.query(
        'INSERT INTO DetalleCompraFactura (ID_CompraFactura, ID_Producto, Cantidad, PrecioCompra) VALUES (?, ?, ?, ?)',
        [ID_CompraFactura, detalle.ID_Producto, detalle.Cantidad, detalle.PrecioCompra]
      );
      await pool.query(
        'UPDATE Producto SET Stock = Stock + ? WHERE ID_Producto = ?',
        [detalle.Cantidad, detalle.ID_Producto]
      );
    }

    res.json({ mensaje: 'Compra registrada correctamente' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al registrar la compra', error: error.message });
  }
};





// Actualizar una compra con sus detalles
export const actualizarCompras = async (req, res) => {
  const { ID_CompraFactura } = req.params;
  const { ID_Proveedores, fecha_compra, total_compra, detalles } = req.body;

  try {
    // Actualizar la compra
    const [compraResult] = await pool.query(
    'UPDATE compra_factura SET ID_Proveedores = ?, fecha_compra = ?, total_compra = ? WHERE ID_CompraFactura = ?',
      [ID_Proveedores, fecha_compra, total_compra, ID_CompraFactura]
    );

    if (compraResult.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Compra no encontrada' });
    }

    // Obtener detalles actuales para restaurar stock
    const [detallesActuales] = await pool.query(
     'SELECT ID_Producto, Cantidad FROM detallecomprafactura WHERE ID_Compra = ?',
      [ID_CompraFactura]
    );

    // Restaurar stock de productos anteriores
    for (const detalle of detallesActuales) {
      await pool.query(
        'UPDATE Producto SET Stock = Stock - ? WHERE ID_Producto = ?',
        [detalle.Cantidad, detalle.ID_Producto]
      );
    }

    // Eliminar detalles actuales
    await pool.query('DELETE FROM detallecomprafactura WHERE ID_CompraFactura = ?', [ID_CompraFactura]);

    // Insertar nuevos detalles y actualizar stock
    for (const detalle of detalles) {
      await pool.query(
    'INSERT INTO detallecomprafactura (ID_CompraFactura, ID_Producto, Cantidad, PrecioCompra) VALUES (?, ?, ?, ?)',
        [ID_CompraFactura, detalle.ID_Producto, detalle.Cantidad, detalle.PrecioCompra]
      );
      await pool.query(
        'UPDATE Producto SET Stock = Stock + ? WHERE ID_Producto = ?',
        [detalle.Cantidad, detalle.ID_Producto]
      );
    }

    res.json({ mensaje: 'Compra actualizada correctamente' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al actualizar la compra', error: error.message });
  }
};

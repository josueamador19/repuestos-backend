USE [RepuestosDB]
GO
ALTER TABLE [dbo].[Usuarios] DROP CONSTRAINT [FK__Usuarios__RolID__5F492382]
GO
ALTER TABLE [dbo].[Usuarios] DROP CONSTRAINT [FK__Usuarios__RolID__2D7CBDC4]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__Usuario__6ABAD62E]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__Usuario__2C88998B]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__MetodoP__6CA31EA0]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__MetodoP__2B947552]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__Direcci__6BAEFA67]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [FK__Pedidos__Direcci__2AA05119]
GO
ALTER TABLE [dbo].[Noticias] DROP CONSTRAINT [FK__Noticias__AutorI__7FB5F314]
GO
ALTER TABLE [dbo].[Noticias] DROP CONSTRAINT [FK__Noticias__AutorI__29AC2CE0]
GO
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [FK__Facturas__Pedido__28B808A7]
GO
ALTER TABLE [dbo].[DireccionesEnvio] DROP CONSTRAINT [FK__Direccion__Usuar__6225902D]
GO
ALTER TABLE [dbo].[DireccionesEnvio] DROP CONSTRAINT [FK__Direccion__Usuar__27C3E46E]
GO
ALTER TABLE [dbo].[DetallePedido] DROP CONSTRAINT [FK__DetallePe__Produ__26CFC035]
GO
ALTER TABLE [dbo].[DetallePedido] DROP CONSTRAINT [FK__DetallePe__Pedid__25DB9BFC]
GO
ALTER TABLE [dbo].[ComentariosNoticias] DROP CONSTRAINT [FK__Comentari__Usuar__24E777C3]
GO
ALTER TABLE [dbo].[Politicas] DROP CONSTRAINT [DF__Politicas__Activ__22FF2F51]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [DF__Pedidos__FechaPe__69C6B1F5]
GO
ALTER TABLE [dbo].[Pedidos] DROP CONSTRAINT [DF__Pedidos__Estado__68D28DBC]
GO
ALTER TABLE [dbo].[Noticias] DROP CONSTRAINT [DF__Noticias__Activo__7EC1CEDB]
GO
ALTER TABLE [dbo].[Noticias] DROP CONSTRAINT [DF__Noticias__FechaP__7DCDAAA2]
GO
ALTER TABLE [dbo].[FAQ] DROP CONSTRAINT [DF__FAQ__Activo__220B0B18]
GO
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [DF__Facturas__Estado__2116E6DF]
GO
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [DF__Facturas__FechaF__2022C2A6]
GO
ALTER TABLE [dbo].[ContactMessages] DROP CONSTRAINT [DF__ContactMe__Estad__1F2E9E6D]
GO
ALTER TABLE [dbo].[ContactMessages] DROP CONSTRAINT [DF__ContactMe__Fecha__1E3A7A34]
GO
ALTER TABLE [dbo].[ComentariosNoticias] DROP CONSTRAINT [DF__Comentari__Fecha__1D4655FB]
GO
/****** Object:  Index [UQ__Usuarios__A9D10534B6736180]    Script Date: 10/11/2025 01:42:03 p. m. ******/
ALTER TABLE [dbo].[Usuarios] DROP CONSTRAINT [UQ__Usuarios__A9D10534B6736180]
GO
/****** Object:  Index [UQ__Usuarios__A9D105340909352C]    Script Date: 10/11/2025 01:42:03 p. m. ******/
ALTER TABLE [dbo].[Usuarios] DROP CONSTRAINT [UQ__Usuarios__A9D105340909352C]
GO
/****** Object:  Index [UQ_Facturas_PedidoID]    Script Date: 10/11/2025 01:42:03 p. m. ******/
ALTER TABLE [dbo].[Facturas] DROP CONSTRAINT [UQ_Facturas_PedidoID]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuarios]') AND type in (N'U'))
DROP TABLE [dbo].[Usuarios]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Productos]') AND type in (N'U'))
DROP TABLE [dbo].[Productos]
GO
/****** Object:  Table [dbo].[Politicas]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Politicas]') AND type in (N'U'))
DROP TABLE [dbo].[Politicas]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pedidos]') AND type in (N'U'))
DROP TABLE [dbo].[Pedidos]
GO
/****** Object:  Table [dbo].[Noticias]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Noticias]') AND type in (N'U'))
DROP TABLE [dbo].[Noticias]
GO
/****** Object:  Table [dbo].[MetodosPago]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MetodosPago]') AND type in (N'U'))
DROP TABLE [dbo].[MetodosPago]
GO
/****** Object:  Table [dbo].[FAQ]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FAQ]') AND type in (N'U'))
DROP TABLE [dbo].[FAQ]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Facturas]') AND type in (N'U'))
DROP TABLE [dbo].[Facturas]
GO
/****** Object:  Table [dbo].[DireccionesEnvio]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DireccionesEnvio]') AND type in (N'U'))
DROP TABLE [dbo].[DireccionesEnvio]
GO
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DetallePedido]') AND type in (N'U'))
DROP TABLE [dbo].[DetallePedido]
GO
/****** Object:  Table [dbo].[ContactMessages]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactMessages]') AND type in (N'U'))
DROP TABLE [dbo].[ContactMessages]
GO
/****** Object:  Table [dbo].[ContactInfo]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactInfo]') AND type in (N'U'))
DROP TABLE [dbo].[ContactInfo]
GO
/****** Object:  Table [dbo].[ComentariosNoticias]    Script Date: 10/11/2025 01:42:03 p. m. ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ComentariosNoticias]') AND type in (N'U'))
DROP TABLE [dbo].[ComentariosNoticias]
GO
/****** Object:  Table [dbo].[ComentariosNoticias]    Script Date: 10/11/2025 01:42:03 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComentariosNoticias](
	[ComentarioID] [int] IDENTITY(1,1) NOT NULL,
	[NoticiaID] [int] NOT NULL,
	[UsuarioID] [int] NULL,
	[Contenido] [nvarchar](max) NOT NULL,
	[Fecha] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComentarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactInfo]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactInfo](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Correo] [nvarchar](100) NULL,
	[Horario] [nvarchar](100) NULL,
	[MapaURL] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactMessages]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactMessages](
	[MensajeID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Asunto] [nvarchar](150) NULL,
	[Mensaje] [nvarchar](max) NULL,
	[FechaEnvio] [datetime] NULL,
	[Estado] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MensajeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallePedido]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePedido](
	[DetalleID] [int] IDENTITY(1,1) NOT NULL,
	[PedidoID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DetalleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DireccionesEnvio]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DireccionesEnvio](
	[DireccionID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[Direccion] [nvarchar](255) NOT NULL,
	[Ciudad] [nvarchar](100) NOT NULL,
	[Departamento] [nvarchar](100) NOT NULL,
	[CodigoPostal] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[DireccionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[FacturaID] [int] IDENTITY(1,1) NOT NULL,
	[PedidoID] [int] NOT NULL,
	[FechaFactura] [datetime] NULL,
	[Subtotal] [decimal](10, 2) NOT NULL,
	[Impuesto] [decimal](10, 2) NOT NULL,
	[Total] [decimal](10, 2) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[CostoEnvio] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[FacturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAQ]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAQ](
	[FAQID] [int] IDENTITY(1,1) NOT NULL,
	[Pregunta] [nvarchar](255) NOT NULL,
	[Respuesta] [nvarchar](max) NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[FAQID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MetodosPago]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetodosPago](
	[MetodoPagoID] [int] IDENTITY(1,1) NOT NULL,
	[Metodo] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MetodoPagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Noticias]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticias](
	[NoticiaID] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](200) NOT NULL,
	[Contenido] [nvarchar](max) NOT NULL,
	[ImagenURL] [nvarchar](255) NULL,
	[AutorID] [int] NULL,
	[FechaPublicacion] [datetime] NULL,
	[Categoria] [nvarchar](100) NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoticiaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[PedidoID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[DireccionID] [int] NOT NULL,
	[MetodoPagoID] [int] NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[FechaPedido] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PedidoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Politicas]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Politicas](
	[PoliticaID] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [nvarchar](50) NOT NULL,
	[Contenido] [nvarchar](max) NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PoliticaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreProducto] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[Categoria] [nvarchar](50) NULL,
	[ImagenURL] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolID] [int] IDENTITY(1,1) NOT NULL,
	[NombreRol] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 10/11/2025 01:42:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Telefono] [nvarchar](20) NOT NULL,
	[RolID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ComentariosNoticias] ON 

INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (1, 1, 2, N'Excelente noticia, justo necesitaba filtros nuevos!', CAST(N'2025-10-05T18:29:14.053' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (2, 2, 3, N'Gracias por los consejos, muy útiles.', CAST(N'2025-10-05T18:29:14.053' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (3, 1, 2, N'Perfecto, ya puedo comprar nuevos filtros.', CAST(N'2025-10-05T18:29:21.887' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (4, 2, 3, N'Lo tomaré en cuenta, muchas gracias', CAST(N'2025-10-05T18:29:21.887' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (6, 1, 1, N'Prueba de comentario desde Frontend', CAST(N'2025-10-05T21:16:44.080' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (7, 2, 1, N'Segunda prueba de comentario desde el frontend', CAST(N'2025-10-05T21:29:04.480' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (9, 8, 1, N'Cierto, si deberian de hacerlo', CAST(N'2025-10-09T21:27:45.397' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (10, 8, 1, N'Test de comentario con usuario
', CAST(N'2025-11-10T11:47:24.257' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (11, 8, 1, N'Con usuario', CAST(N'2025-11-10T11:55:34.177' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (12, 2, 6, N'Hola', CAST(N'2025-11-10T11:57:17.143' AS DateTime))
INSERT [dbo].[ComentariosNoticias] ([ComentarioID], [NoticiaID], [UsuarioID], [Contenido], [Fecha]) VALUES (13, 2, 6, N'Hola', CAST(N'2025-11-10T11:57:18.487' AS DateTime))
SET IDENTITY_INSERT [dbo].[ComentariosNoticias] OFF
GO
SET IDENTITY_INSERT [dbo].[ContactInfo] ON 

INSERT [dbo].[ContactInfo] ([ContactID], [Direccion], [Telefono], [Correo], [Horario], [MapaURL]) VALUES (1, N'Edificio B2, UNAH, Tegucigalpa, Honduras', N'2234-5678', N'contacto@repuestos.com', N'Lunes a Viernes 8:00 AM - 5:00 PM', N'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d11911.847036444306!2d-87.18049421654676!3d14.086694711416467!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8f6fa34a7bd7df3f%3A0x8e68174348ad328e!2sEdificio%20B2%20Facultad%20De%20Ingenier%C3%ADa!5e1!3m2!1ses-419!2shn!4v1760062861200!5m2!1ses-419!2shn" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade')
SET IDENTITY_INSERT [dbo].[ContactInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[ContactMessages] ON 

INSERT [dbo].[ContactMessages] ([MensajeID], [Nombre], [Email], [Asunto], [Mensaje], [FechaEnvio], [Estado]) VALUES (2, N'Oscar Amador', N'oscar123@gmail.com', N'Test ', N'Esta es una prueba de mensaje ', CAST(N'2025-10-09T20:45:42.113' AS DateTime), N'Pendiente')
SET IDENTITY_INSERT [dbo].[ContactMessages] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallePedido] ON 

INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (1, 1, 1, 2, CAST(250.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (2, 1, 3, 4, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (3, 2, 4, 1, CAST(850.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (4, 2, 7, 1, CAST(3200.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallePedido] ([DetalleID], [PedidoID], [ProductoID], [Cantidad], [PrecioUnitario]) VALUES (5, 3, 8, 3, CAST(450.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallePedido] OFF
GO
SET IDENTITY_INSERT [dbo].[DireccionesEnvio] ON 

INSERT [dbo].[DireccionesEnvio] ([DireccionID], [UsuarioID], [Direccion], [Ciudad], [Departamento], [CodigoPostal]) VALUES (1, 2, N'Col. Centro, Calle Principal #123', N'Tegucigalpa', N'Francisco Morazán', N'11101')
INSERT [dbo].[DireccionesEnvio] ([DireccionID], [UsuarioID], [Direccion], [Ciudad], [Departamento], [CodigoPostal]) VALUES (2, 3, N'Barrio Abajo, Avenida 4', N'San Pedro Sula', N'Cortés', N'21101')
INSERT [dbo].[DireccionesEnvio] ([DireccionID], [UsuarioID], [Direccion], [Ciudad], [Departamento], [CodigoPostal]) VALUES (3, 4, N'Residencial Los Pinos, Casa #45', N'La Ceiba', N'Atlántida', N'31101')
SET IDENTITY_INSERT [dbo].[DireccionesEnvio] OFF
GO
SET IDENTITY_INSERT [dbo].[Facturas] ON 

INSERT [dbo].[Facturas] ([FacturaID], [PedidoID], [FechaFactura], [Subtotal], [Impuesto], [Total], [Estado], [CostoEnvio]) VALUES (1, 1, CAST(N'2025-09-26T09:29:47.233' AS DateTime), CAST(1100.00 AS Decimal(10, 2)), CAST(165.00 AS Decimal(10, 2)), CAST(1265.00 AS Decimal(10, 2)), N'Pendiente', NULL)
SET IDENTITY_INSERT [dbo].[Facturas] OFF
GO
SET IDENTITY_INSERT [dbo].[FAQ] ON 

INSERT [dbo].[FAQ] ([FAQID], [Pregunta], [Respuesta], [Activo]) VALUES (1, N'¿Cuánto tarda el envío?', N'El tiempo de entrega es de 2 a 5 días hábiles dependiendo de su ubicación.', 1)
INSERT [dbo].[FAQ] ([FAQID], [Pregunta], [Respuesta], [Activo]) VALUES (2, N'¿Puedo pagar contra entrega?', N'Sí, aceptamos pago en efectivo al momento de la entrega en ciertas ciudades.', 1)
INSERT [dbo].[FAQ] ([FAQID], [Pregunta], [Respuesta], [Activo]) VALUES (3, N'¿Tienen garantía los productos?', N'Sí, todos nuestros repuestos cuentan con garantía de 30 días por defectos de fábrica.', 1)
SET IDENTITY_INSERT [dbo].[FAQ] OFF
GO
SET IDENTITY_INSERT [dbo].[MetodosPago] ON 

INSERT [dbo].[MetodosPago] ([MetodoPagoID], [Metodo]) VALUES (1, N'Tarjeta de Crédito')
INSERT [dbo].[MetodosPago] ([MetodoPagoID], [Metodo]) VALUES (2, N'Tarjeta de Débito')
INSERT [dbo].[MetodosPago] ([MetodoPagoID], [Metodo]) VALUES (3, N'Efectivo contra entrega')
SET IDENTITY_INSERT [dbo].[MetodosPago] OFF
GO
SET IDENTITY_INSERT [dbo].[Noticias] ON 

INSERT [dbo].[Noticias] ([NoticiaID], [Titulo], [Contenido], [ImagenURL], [AutorID], [FechaPublicacion], [Categoria], [Activo]) VALUES (1, N'Nuevo lote de filtros disponibles', N'Llegó un nuevo lote de filtros de aire y aceite con descuentos especiales por tiempo limitado.', N'noticia_filtros.jpg', 1, CAST(N'2025-11-10T13:39:12.800' AS DateTime), N'Promociones', 1)
INSERT [dbo].[Noticias] ([NoticiaID], [Titulo], [Contenido], [ImagenURL], [AutorID], [FechaPublicacion], [Categoria], [Activo]) VALUES (2, N'Mantenimiento preventivo: la clave para alargar la vida del motor', N'Te compartimos las mejores prácticas para mantener tu motor en óptimo estado y evitar reparaciones costosas.', N'mantenimiento_motor.jpg', 1, CAST(N'2025-11-10T13:39:12.800' AS DateTime), N'Consejos', 1)
SET IDENTITY_INSERT [dbo].[Noticias] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([PedidoID], [UsuarioID], [DireccionID], [MetodoPagoID], [Estado], [FechaPedido]) VALUES (1, 2, 1, 1, N'Pendiente', CAST(N'2025-11-10T13:39:12.770' AS DateTime))
INSERT [dbo].[Pedidos] ([PedidoID], [UsuarioID], [DireccionID], [MetodoPagoID], [Estado], [FechaPedido]) VALUES (2, 3, 2, 2, N'Completado', CAST(N'2025-11-10T13:39:12.770' AS DateTime))
INSERT [dbo].[Pedidos] ([PedidoID], [UsuarioID], [DireccionID], [MetodoPagoID], [Estado], [FechaPedido]) VALUES (3, 4, 3, 3, N'Enviado', CAST(N'2025-11-10T13:39:12.770' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Politicas] ON 

INSERT [dbo].[Politicas] ([PoliticaID], [Tipo], [Contenido], [Activo]) VALUES (1, N'Devoluciones y Cambios', N'Las devoluciones se aceptan dentro de los 15 días posteriores a la compra con el producto en su empaque original.', 1)
INSERT [dbo].[Politicas] ([PoliticaID], [Tipo], [Contenido], [Activo]) VALUES (2, N'Envíos', N'Realizamos envíos a todo el país mediante paquetería certificada. El costo depende de la ubicación.', 1)
INSERT [dbo].[Politicas] ([PoliticaID], [Tipo], [Contenido], [Activo]) VALUES (3, N'Privacidad', N'Sus datos personales serán utilizados únicamente para procesar sus pedidos y no serán compartidos con terceros.', 1)
INSERT [dbo].[Politicas] ([PoliticaID], [Tipo], [Contenido], [Activo]) VALUES (4, N'Generales', N'El uso de este sitio web implica la aceptación de nuestras políticas de uso y servicio.', 1)
INSERT [dbo].[Politicas] ([PoliticaID], [Tipo], [Contenido], [Activo]) VALUES (5, N'Garantía', N'Todos los productos cuentan con garantía mínima de 30 días, extensible según el fabricante.', 1)
SET IDENTITY_INSERT [dbo].[Politicas] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (1, N'Filtro de aceite', N'Filtro de aceite para motor 1.6L', CAST(250.00 AS Decimal(10, 2)), 38, N'Filtros', N'filtro_aceite.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (2, N'Filtro de aire', N'Filtro de aire de alto rendimiento', CAST(320.00 AS Decimal(10, 2)), 30, N'Filtros', N'filtro_aire.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (3, N'Bujía NGK', N'Bujía estándar para motor gasolina', CAST(150.00 AS Decimal(10, 2)), 96, N'Encendido', N'bujia_ngk.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (4, N'Pastillas de freno', N'Juego de pastillas de freno delanteras', CAST(850.00 AS Decimal(10, 2)), 24, N'Frenos', N'pastillas_freno.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (5, N'Disco de freno', N'Disco ventilado delantero 280mm', CAST(1200.00 AS Decimal(10, 2)), 20, N'Frenos', N'disco_freno.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (6, N'Amortiguador delantero', N'Amortiguador hidráulico delantero', CAST(2100.00 AS Decimal(10, 2)), 15, N'Suspensión', N'amortiguador.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (7, N'Batería 12V 60Ah', N'Batería libre de mantenimiento', CAST(3200.00 AS Decimal(10, 2)), 9, N'Eléctrico', N'bateria.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (8, N'Aceite sintético 5W30', N'Aceite sintético premium 1L', CAST(450.00 AS Decimal(10, 2)), 57, N'Lubricantes', N'aceite_5w30.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (9, N'Radiador aluminio', N'Radiador de aluminio con ventilador', CAST(5400.00 AS Decimal(10, 2)), 8, N'Refrigeración', N'radiador.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (10, N'Alternador', N'Alternador 12V 90A para motor gasolina', CAST(6500.00 AS Decimal(10, 2)), 5, N'Eléctrico', N'alternador.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (11, N'Clutch kit', N'Kit completo de clutch (disco y prensa)', CAST(4800.00 AS Decimal(10, 2)), 7, N'Transmisión', N'clutch.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (12, N'Correa de distribución', N'Correa reforzada para motor 2.0L', CAST(1500.00 AS Decimal(10, 2)), 18, N'Motor', N'correa.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (13, N'Sensor de oxígeno', N'Sensor de oxígeno universal 4 pines', CAST(2300.00 AS Decimal(10, 2)), 12, N'Sensores', N'sensor_oxigeno.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (14, N'Parabrisas delantero', N'Vidrio templado para sedan', CAST(7200.00 AS Decimal(10, 2)), 3, N'Carrocería', N'parabrisas.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (15, N'Espejo retrovisor', N'Espejo retrovisor eléctrico izquierdo', CAST(1800.00 AS Decimal(10, 2)), 6, N'Carrocería', N'retrovisor.jpg')
INSERT [dbo].[Productos] ([ProductoID], [NombreProducto], [Descripcion], [Precio], [Stock], [Categoria], [ImagenURL]) VALUES (17, N'Espejo retrovisor', N'Espejo retrovisor eléctrico izquierdo', CAST(1800.00 AS Decimal(10, 2)), 6, N'Carrocería', N'retrovisor.jpg')
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (1, N'Vendedor')
INSERT [dbo].[Roles] ([RolID], [NombreRol]) VALUES (2, N'Comprador')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (1, N'Juan Pérez', N'juanperez@repuestos.com', N'hash123', N'9999-1111', 1)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (2, N'Carlos López', N'carlos@gmail.com', N'hash456', N'8888-2222', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (3, N'María García', N'maria@gmail.com', N'hash789', N'8777-3333', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (4, N'Pedro Sánchez', N'pedro@gmail.com', N'hash321', N'8666-4444', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (5, N'Cliente Invitado', N'invitado@temp.com', N'nohash', N'0000-0000', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [Telefono], [RolID]) VALUES (6, N'Oscar Amador', N'oscar123@gmail.com', N'Contrasena.1', N'88482479', 2)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [UQ_Facturas_PedidoID]    Script Date: 10/11/2025 01:42:04 p. m. ******/
ALTER TABLE [dbo].[Facturas] ADD  CONSTRAINT [UQ_Facturas_PedidoID] UNIQUE NONCLUSTERED 
(
	[PedidoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__A9D105340909352C]    Script Date: 10/11/2025 01:42:04 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__A9D10534B6736180]    Script Date: 10/11/2025 01:42:04 p. m. ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComentariosNoticias] ADD  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[ContactMessages] ADD  DEFAULT (getdate()) FOR [FechaEnvio]
GO
ALTER TABLE [dbo].[ContactMessages] ADD  DEFAULT ('Pendiente') FOR [Estado]
GO
ALTER TABLE [dbo].[Facturas] ADD  DEFAULT (getdate()) FOR [FechaFactura]
GO
ALTER TABLE [dbo].[Facturas] ADD  DEFAULT ('Pendiente') FOR [Estado]
GO
ALTER TABLE [dbo].[FAQ] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Noticias] ADD  DEFAULT (getdate()) FOR [FechaPublicacion]
GO
ALTER TABLE [dbo].[Noticias] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT ('Pendiente') FOR [Estado]
GO
ALTER TABLE [dbo].[Pedidos] ADD  DEFAULT (getdate()) FOR [FechaPedido]
GO
ALTER TABLE [dbo].[Politicas] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[ComentariosNoticias]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD FOREIGN KEY([PedidoID])
REFERENCES [dbo].[Pedidos] ([PedidoID])
GO
ALTER TABLE [dbo].[DetallePedido]  WITH CHECK ADD FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[DireccionesEnvio]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[DireccionesEnvio]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD FOREIGN KEY([PedidoID])
REFERENCES [dbo].[Pedidos] ([PedidoID])
GO
ALTER TABLE [dbo].[Noticias]  WITH CHECK ADD FOREIGN KEY([AutorID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Noticias]  WITH CHECK ADD FOREIGN KEY([AutorID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([DireccionID])
REFERENCES [dbo].[DireccionesEnvio] ([DireccionID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([DireccionID])
REFERENCES [dbo].[DireccionesEnvio] ([DireccionID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([MetodoPagoID])
REFERENCES [dbo].[MetodosPago] ([MetodoPagoID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([MetodoPagoID])
REFERENCES [dbo].[MetodosPago] ([MetodoPagoID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO

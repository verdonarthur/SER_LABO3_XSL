<?xml version="1.0" ?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" media-type="text/html; charset=UTF-8"/>

	<xsl:variable name="document_visites" select="document('projections.xml')"/>

	<xsl:template match="/">
		<html>
			<head>
				<!-- jQuery -->
				<script src="js/jquery.js"></script>

				<!-- Bootstrap Core JavaScript -->
				<script src="js/bootstrap.min.js"></script>

				<title>Listes des projections</title>
				<style type="text/css">
					@import url("./css/bootstrap.min.css");
					@import url("./css/3-col-portfolio.css");
				</style>
			</head>
			<body>
				<!-- Navigation -->
				<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
					<div class="container">
						<!-- Brand and toggle get grouped for better mobile display -->
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="#">Projections</a>
						</div>
						<!-- Collect the nav links, forms, and other content for toggling -->
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
								<li>
									<a href="#">Tri par nom</a>
								</li>
								<li>
									<a href="#">Tri par classement</a>
								</li>
								<li>
									<a href="#">Tri par heure</a>
								</li>
							</ul>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container -->
				</nav>
				<!-- Page Content -->
				<div class="container">

					<!-- Page Header -->
					<div class="row">
						<div class="col-lg-12">
							<!--<h1 class="page-header">Liste des films
						</h1>-->
						</div>
					</div>
					<!-- /.row -->

					<!-- Film Row -->
					<xsl:call-template name="movieByName"/>
					<xsl:call-template name="movieByRating"/>
					<xsl:call-template name="movieByHour"/>
					<!--<xsl:call-template name="filmAffiche"/>-->

					<!-- /.row -->

				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="movieByName">
		<h1>Liste des films par nom</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="ascending" select="titre"/>
			<div class="row">
				<div class="col-md-5">
					<img class="img-movies img-responsive ">

						<xsl:attribute name="src">
							<xsl:value-of select="./photo"/>
						</xsl:attribute>
					</img>
				</div>
				<div class="col-md-7">
					<h3><xsl:value-of select="titre"/></h3>
					<h4></h4>
					<p><xsl:value-of select="synopsis"/></p>
					<!--<a class="btn btn-primary" href="#">View Project
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>-->
				</div>
			</div>
			<hr></hr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="movieByRating">
		<h1>Liste des films par note</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="ascending" select="((sum(critique/note)) div (count(critique)))"/>

			<div class="row">
				<div class="col-md-5">
					<img class="img-movies img-responsive ">

						<xsl:attribute name="src">
							<xsl:value-of select="./photo"/>
						</xsl:attribute>
					</img>
				</div>
				<div class="col-md-7">
					<h3><xsl:value-of select="titre"/></h3>
					<h4></h4>
					<p><xsl:value-of select="synopsis"/></p>
					<!--<a class="btn btn-primary" href="#">View Project
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>-->
				</div>
			</div>
			<hr></hr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="movieByHour">
		<h1>Liste des films par date</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="ascending" select="../date"/>
			<div class="row">
				<div class="col-md-5">
					<img class="img-movies img-responsive ">

						<xsl:attribute name="src">
							<xsl:value-of select="./photo"/>
						</xsl:attribute>
					</img>
				</div>
				<div class="col-md-7">
					<h3><xsl:value-of select="titre"/></h3>
					<h4></h4>
					<p><xsl:value-of select="synopsis"/></p>
					<!--<a class="btn btn-primary" href="#">View Project
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>-->
				</div>
			</div>
			<hr></hr>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>

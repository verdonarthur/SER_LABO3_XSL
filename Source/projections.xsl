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

				<script src="js/rater.min.js"></script>

				<script>
					$(document).ready(function () {
						$(".stars").rate({readonly: true});
					});
				</script>

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
									<a href="#byName">Tri par nom</a>
								</li>
								<li>
									<a href="#byRate">Tri par classement</a>
								</li>
								<li>
									<a href="#byHour">Tri par heure</a>
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
		<h1 id="byName">Liste des films par nom</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="ascending" select="titre"/>

			<xsl:apply-templates select="../film" mode="list"/>

		</xsl:for-each>
	</xsl:template>

	<xsl:template name="movieByRating">
		<h1 id="byRate">Liste des films par note</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="descending" select="((sum(critique/note)) div (count(critique)))"/>

			<xsl:apply-templates select="../film" mode="list"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="movieByHour">
		<h1 id="byHour">Liste des films par date</h1>

		<xsl:for-each select="//projection/film">

			<xsl:sort order="ascending" select="../date"/>

			<xsl:apply-templates select="../film" mode="list"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="acteur" mode="liste">

		<xsl:variable name="actorName" select="translate(translate(nom,',',''),' ','')"/>
		<a href="#{$actorName}-details" data-toggle="modal">
			<li>
				<xsl:value-of select="nom"/>
			</li>
		</a>

	</xsl:template>

	<xsl:template match="acteur" mode="details">

		<xsl:variable name="actorName" select="translate(translate(nom,',',''),' ','')"/>
		<div class="modal fade" tabindex="-1" role="dialog" id="{$actorName}-details">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true"></span>
						</button>
						<h4 class="modal-title"><xsl:value-of select="nom"/>
							- détails</h4>
					</div>
					<div class="modal-body">
						<p>
							Date de naissance :

							<xsl:value-of select="date_naissance"/><br/>
							Date de décès :

							<xsl:value-of select="date_deces"/><br/>
							Genre :

							<xsl:value-of select="sexe"/><br/>
						</p>
						<p><xsl:value-of select="biographie"/></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

	</xsl:template>

	<xsl:template match="film" mode="list">

		<xsl:variable name="filmName" select="translate(titre,' ','')"/>

		<xsl:variable name="rating" select="((sum(critique/note)) div (count(critique)))"/>

		<xsl:variable name="pseudoId" select="concat(string-length(titre),string-length(synopsis),duree)"/>

		<div class="row">
			<div class="col-md-5">
				<img class="img-movies img-responsive ">

					<xsl:attribute name="src">
						<xsl:value-of select="./photo"/>
					</xsl:attribute>
				</img>
			</div>
			<div class="col-md-7">
				<h3>
					<xsl:value-of select="titre"/>
				</h3>
				<h4>
					<div class="stars" style="display:inline-block" data-rate-value="{$rating}"></div>
				</h4>
				<h5>

					<xsl:value-of select="duree"/>
					min.,

					<xsl:value-of select="../date"/>,

					salle num. <xsl:value-of select="../salleNum"/>

				</h5>
				<p><xsl:value-of select="synopsis"/></p>

				<div class="panel-group" id="accordion-{$pseudoId}" role="tablist" aria-multiselectable="false">
					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingActor-{$pseudoId}">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-{$pseudoId}" href="#actor-{$pseudoId}" aria-expanded="false" aria-controls="actor-{$pseudoId}">
									Acteurs
								</a>
							</h4>
						</div>
						<div id="actor-{$pseudoId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingActor-{$pseudoId}">
							<div class="panel-body">

								<ul>
									<xsl:apply-templates select="./role/acteur" mode="liste"/>
								</ul>

								<xsl:apply-templates select="./role/acteur" mode="details"/>

							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingGenre-{$pseudoId}">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-{$pseudoId}" href="#genre-{$pseudoId}" aria-expanded="false" aria-controls="genre-{$pseudoId}">
									Genres
								</a>
							</h4>
						</div>
						<div id="genre-{$pseudoId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingGenre-{$pseudoId}">
							<div class="panel-body">

								<xsl:for-each select="./genre">
									<button class="btn btn-default btn-xs disabled" ><xsl:value-of select="."/>
								</button>
								</xsl:for-each>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingMotcle-{$pseudoId}">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-{$pseudoId}" href="#motcle-{$pseudoId}" aria-expanded="false" aria-controls="motcle-{$pseudoId}">
									Mot-clé
								</a>
							</h4>
						</div>
						<div id="motcle-{$pseudoId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingMotcle-{$pseudoId}">
							<div class="panel-body">

								<xsl:for-each select="./motcle">
									<button class="btn btn-default btn-xs disabled" ><xsl:value-of select="."/>
								</button>
								</xsl:for-each>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingLangue-{$pseudoId}">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-{$pseudoId}" href="#langue-{$pseudoId}" aria-expanded="false" aria-controls="langue-{$pseudoId}">
									Langue
								</a>
							</h4>
						</div>
						<div id="langue-{$pseudoId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingLangue-{$pseudoId}">
							<div class="panel-body">

								<xsl:for-each select="./langage">
									<button class="btn btn-default btn-xs disabled" ><xsl:value-of select="."/>
								</button>
								</xsl:for-each>
							</div>
						</div>
					</div>

					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingReview-{$pseudoId}">
							<h4 class="panel-title">
								<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion-{$pseudoId}" href="#review-{$pseudoId}" aria-expanded="false" aria-controls="review-{$pseudoId}">
									Critiques
								</a>
							</h4>
						</div>
						<div id="review-{$pseudoId}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingReview-{$pseudoId}">
							<div class="panel-body">

								<xsl:for-each select="./critique">
									<div>
										<xsl:variable name="reviewRating" select="note"/>
										<div class="stars" data-rate-value="{$reviewRating}"></div>
										<xsl:value-of select="texte"/>
								</div>
								</xsl:for-each>
							</div>
						</div>
					</div>

					<!--
					#TODO LANGUE, Salle utilisee et critique des films
				-->

				</div>

			</div>
		</div>
		<hr></hr>
	</xsl:template>

</xsl:stylesheet>

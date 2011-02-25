<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
   Modificatiosnot javancs.xsl original Copyright (c) 2009 Fred Grott
   ASfv2 license where appplicable.
-->
<!DOCTYPE javancss [
  <!-- ====================================================================
       Mapping of images onto files
       ==================================================================== -->
  <!ENTITY logoImg            "images/javancss.png">
  <!ENTITY companylogoImg     "images/companylogo.png">
  <!ENTITY linkImg            "images/link.png">
  <!ENTITY mixedCycleLinkImg       "images/mixedCycleLink.png">
  <!ENTITY innerCycleLinkImg       "images/innerCycleLink.png">
  <!ENTITY mixImg             "images/mix.png">
  <!ENTITY packageImg         "images/package.png">
  <!ENTITY innerImg           "images/inner.png">
  <!ENTITY classImg           "images/class.png">
  <!ENTITY abstractImg        "images/abstract.png">
  <!ENTITY interfaceImg       "images/interface.png">
  <!ENTITY innerclassImg      "images/innerclass.png">
  <!ENTITY innerabstractImg   "images/innerabstract.png">
  <!ENTITY innerinterfaceImg  "images/innerinterface.png">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:param name="project" select="files"/>
<xsl:param name="today" select="today"/>

  <xsl:template match="/">
    <html>
    <head>
    <META HTTP-EQUIV="Content-Style-Type" CONTENT="text/css"/>
    <title>JavaNCSS Analysis for <xsl:value-of select="$project"/></title>
    <link rel="stylesheet" type="text/css" href="reports.css"/>
    </head>  
    <body>
        <h1><img src="&companylogoImg;"/></h1>
        <h1>
        <a name="top"><img src="&logoImg;"/>JavaNCSS Analysis for <xsl:value-of select="$project"/> on <xsl:value-of select="$today"/></a>
        </h1>
        <p align="right">Designed for use with <a href="http://www.kclee.de/clemens/java/javancss/">JavaNCSS</a> and <a href="http://ant.apache.org">Apache Ant</a>.</p>
        <hr size="2"/>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="packages">
    <h2>Packages</h2>
    <table class="details" border="0" width="100%">
      <tr>
        <th>Nr.</th>
        <th>Classes</th>
        <th>Functions</th>
        <th>NCSS</th>
        <th>Javadocs</th>
        <th>Package</th>
      </tr>
      <xsl:apply-templates select="package"/>
      <tr>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
        <td>&#160;</td>
      </tr>
      <tr>
        <td>&#160;</td>
        <td><xsl:value-of select="total/classes"/></td>  
        <td><xsl:value-of select="total/functions"/></td>  
        <td><xsl:value-of select="total/ncss"/></td>  
        <td><xsl:value-of select="total/javadocs"/></td>
        <td>Total</td>  
      </tr>
    </table>
    <p/>
    <xsl:apply-templates select="table"/>
  </xsl:template>

  <xsl:template match="package">
    <tr>
      <td><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="classes"/></td>
      <td><xsl:value-of select="functions"/></td>
      <td><xsl:value-of select="ncss"/></td>
      <td><xsl:value-of select="javadocs"/></td>
      <td><xsl:value-of select="name"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="table">
    <table class="details" border="0" width="100%">
      <xsl:apply-templates select="tr"/>
    </table>
    <p/>  
  </xsl:template>

  <xsl:template match="tr">
    <xsl:variable name="row"><xsl:value-of select="position()"/></xsl:variable>
    <tr>
      <xsl:apply-templates select="td">
        <xsl:with-param name="row"><xsl:value-of select="$row"/></xsl:with-param>
      </xsl:apply-templates>
    </tr>
  </xsl:template>

  <xsl:template match="td">
    <xsl:param name="row" select="3"/>
    <xsl:choose>
      <xsl:when test="$row='1'">
        <th>
          <xsl:if test="position()=6">
            <xsl:text>|</xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>&#160;
        </th>
      </xsl:when>
      <xsl:otherwise>
        <td>
          <xsl:if test="position()=6">
            <xsl:text>| </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>&#160;
        </td>      
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="objects">
    <h2>Objects</h2>
    <table class="details" border="0" width="100%">
      <tr>
        <th>Nr.</th>
        <th>NCSS</th>
        <th>Functions</th>
        <th>Classes</th>
        <th>Javadocs</th>
        <th>Class</th>
      </tr>
      <xsl:apply-templates select="object"/>
      <tr>
        <td colspan="5">Average Object NCSS:</td>
        <td><xsl:value-of select="averages/ncss"/></td>
      </tr>
      <tr>
        <td colspan="5">Average Object Functions:</td>
        <td><xsl:value-of select="averages/functions"/></td>
      </tr>
      <tr>
        <td colspan="5">Average Object Inner Classes:</td>
        <td><xsl:value-of select="averages/classes"/></td>
      </tr>
      <tr>
        <td colspan="5">Average Object Javadoc Comments:</td>
        <td><xsl:value-of select="averages/javadocs"/></td>
      </tr>
      <tr>
        <td colspan="5">Program NCSS:</td>
        <td><xsl:value-of select="ncss"/></td>
      </tr>
    </table>
    <p/>  
  </xsl:template>

  <xsl:template match="object">
    <tr>
      <td><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="ncss"/></td>
      <td><xsl:value-of select="functions"/></td>
      <td><xsl:value-of select="classes"/></td>
      <td><xsl:value-of select="javadocs"/></td>
      <td><xsl:value-of select="name"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="functions">
    <h2>Functions</h2>
    <table class="details" border="0" width="100%">
      <tr>
        <th>Nr.</th>
        <th>NCSS</th>
        <th>CCN</th>
        <th>Javadoc</th>
        <th>Function</th>
      </tr>
      <xsl:apply-templates select="function"/>
      <tr>
        <td colspan="4">Average Function NCSS:</td>
        <td><xsl:value-of select="function_averages/ncss"/></td>
      </tr>
      <tr>
        <td colspan="4">Average Function CCN:</td>
        <td><xsl:value-of select="function_averages/ccn"/></td>
      </tr>
      <tr>
        <td colspan="4">Average Function Javadocs:</td>
        <td><xsl:value-of select="function_averages/javadocs"/></td>
      </tr>
      <tr>
        <td colspan="4">Program NCSS:</td>
        <td><xsl:value-of select="ncss"/></td>
      </tr>
    </table>
    <p/>
  </xsl:template>

  <xsl:template match="function">
    <xsl:variable name="ccn-color">
      <xsl:choose>
        <xsl:when test="ccn &gt; '9'">#ff0000</xsl:when>
        <xsl:otherwise>#000000</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="jdocs-color">
      <xsl:choose>
        <xsl:when test="javadocs &lt; '1'">#ff0000</xsl:when>
        <xsl:otherwise>#000000</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <tr>
      <td><xsl:value-of select="position()"/></td>
      <td><xsl:value-of select="ncss"/></td>
      <td><font color="{$ccn-color}"><xsl:value-of select="ccn"/></font></td>
      <td><font color="{$jdocs-color}"><xsl:value-of select="javadocs"/></font></td>
      <td><xsl:value-of select="name"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>

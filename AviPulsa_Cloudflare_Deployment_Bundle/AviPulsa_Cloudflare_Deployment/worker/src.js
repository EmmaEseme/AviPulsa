export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const cors = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET,POST,OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type, Authorization",
      "Content-Type": "application/json; charset=utf-8"
    };
    if (request.method === "OPTIONS") return new Response(null, { headers: cors });
    if (url.pathname === "/api/health" && request.method === "GET") {
      return Response.json({
        ok: true,
        service: "AviPulsa API starter",
        version: "0.1.0",
        databaseConfigured: Boolean(env.DB),
        note: "Health endpoint only. The current frontend does not sync farm records to this Worker."
      }, { headers: cors });
    }
    return Response.json({
      ok: false,
      error: "Endpoint not implemented",
      message: "This Worker is a deployment starter, not a production farm-data API."
    }, { status: 404, headers: cors });
  }
};
